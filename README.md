# Graduation Grade

Application that help you make **predictions about your graduation grade**.

## Project goal

During the last semester of my bachelor's degree, I started worrying about my grade average, because I wanted to finish my degree with a good GPA.

I started to make some predictions about how the last exams could go and how the different grades could affect my grade average. By using only the calculator, calculating my GPA was really boring because I had to recalculate the grade average with all the marks each time. Thus, since I wanted to learn how to develop a
mobile application, I came up with the idea to create an **application** that can be useful to all 
**university students** that wants to make predictions about their future graduation grade.

Graduation Grade allows you to **calculate your graduation grade** by entering your marks and
modifying them, with a very simple and quick interface.

## Project description

Graduation Grade is developed using the **dart** language and the **Flutter** framework. I made this choice because even though this application is launched only on **Google Play Store** for now, provided I will have the time and the possibility to test this application with iOS devices as well, my intention is to
launch Graduation Grade also on Apple App Store in the future.

I used the **MVC pattern** in order to manage the communications between internal logic and user 
interface. This is really useful, because it helped me create a scalable and well defined
structure for this  project.<br />
The MVC pattern is supported also by **Observable pattern** to handle the notification between 
Model, View and Controller, and by **Command pattern** in order to create a very scalable process 
that is able to control its behavior when different types of event happen during the use of the
application.<br />
Finally, I used the **Cubit pattern**, which is a pattern that allows me to update the user
interface when an event happens through the emission of states relative to that event.

I decided to write the **test** only for the classes useful for the internal logic of the model and
for the pattern template that do not contains code about View for the reasons listed below:
- I did not have enough time, because of university and thesis internship
- I was and am currently not interested in learning how to run test for Flutter UI, because with this project I realized I do not want to work on front-end.
- I was more interested in testing the part responsible for the calculation of graduation grade and for the managing the single exams' grades, in order to ensure correct results and to help students with this task.
  
## Download
Google Play Store: [Graduation Grade](https://pages.github.com/)
