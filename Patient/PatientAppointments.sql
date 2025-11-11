create table PatientAppointments(PatientId varchar2(2), AppointmentDate date);

insert into PatientAppointments values('P1', to_date('2024-02-01', 'yyyy-mm-dd'));
insert into PatientAppointments values('P1', to_date('2024-02-10', 'yyyy-mm-dd'));
insert into PatientAppointments values('P1', to_date('2024-02-25', 'yyyy-mm-dd'));
insert into PatientAppointments values('P2', to_date('2024-03-01', 'yyyy-mm-dd'));
insert into PatientAppointments values('P2', to_date('2024-03-20', 'yyyy-mm-dd'));

Commit;

SELECT
    patientid,
    appointmentdate,
    LEAD(appointmentdate, 1,NULL)
    OVER(PARTITION BY patientid
         ORDER BY
             appointmentdate
    ) AS next_appointment_date
FROM
    patientappointments;