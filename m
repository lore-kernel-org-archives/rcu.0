Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B4C3DA78
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 04:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjAQEet (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjAQEeq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 23:34:46 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A382196F
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 20:34:45 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id i12so20921622qvs.2
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 20:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXfVm8G4okhY+2uqdoMdASq83k6CW3lqeQ4dkk5E7SU=;
        b=Dex/HSTEswFU8NanM1eTD5t1FfowPk7Zuckzl7bMCPNJ0dSeUbfd6h4R/33zBe1lTb
         AFWFiWAhPtt7b9/EICYQBHPGkvTYCeSlFz3l9R8y70sIROkFGTbjj5dffBbaleoiYaGh
         hGBRVvlx9ugqliti5Eha0vD7zW9ue4V5g2VYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXfVm8G4okhY+2uqdoMdASq83k6CW3lqeQ4dkk5E7SU=;
        b=MvM3nPeT+rs0DkJM89ygqN8Ot4NQ6f7JHZPqwk2YijoSoZHBIkh3668GwJXtu9uX0K
         FY+JR57Xyny/3M/oQV1obT0B4+9X90h3bb0BWvP1VvHCSGiO/cdsehc8gYINhIu3qCBQ
         EXc0+i5DYO4wnWe6giZ3iMns2islp14/gGWcOUi99KTAKHSqadMIEOKV+XvmXsNYbWDC
         gWFSXBAu4Ne7R6RG9pqOa8WdNZYABnqy6GcoY9k49LchSVJwxF/OPyvnDviXkPIRdHEh
         RiToPEeYhd2aMH824kX4itA8kRy4tIptllIA55+nwqvp/F8Xs0/vib29cU7TUjDvvHAC
         YNkA==
X-Gm-Message-State: AFqh2krNXM6CXy3F5Zl5RJF9D4Q/l2Bdvk3XS6rS4c2r3uq/HaB5lCi7
        8UfKBBTB9W5mbE38szueXXVeAg==
X-Google-Smtp-Source: AMrXdXv0gDxkyAt3pdyiuhwtaHBl0fwzRRzGg+AA9YJcApH22UJEu1wNljZ7g6d9lH/3lVTpmT3lOg==
X-Received: by 2002:a05:6214:398b:b0:51f:f4f4:e4f8 with SMTP id ny11-20020a056214398b00b0051ff4f4e4f8mr2875893qvb.25.1673930084597;
        Mon, 16 Jan 2023 20:34:44 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006fcb77f3bd6sm19709390qkp.98.2023.01.16.20.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 20:34:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Date:   Mon, 16 Jan 2023 23:34:32 -0500
Message-Id: <6191067A-8033-4670-BBD0-873C5F9E8878@joelfernandes.org>
References: <CAABZP2zHs+Zatp+SUWNsPzGn81StKF9WL_+XB3pVTJNakxh5Dw@mail.gmail.com>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <CAABZP2zHs+Zatp+SUWNsPzGn81StKF9WL_+XB3pVTJNakxh5Dw@mail.gmail.com>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 16, 2023, at 10:15 PM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>=20
> =EF=BB=BFOn Tue, Jan 17, 2023 at 9:45 AM Joel Fernandes <joel@joelfernande=
s.org> wrote:
>>=20
>>> On Tue, Jan 17, 2023 at 08:37:16AM +0800, Zhouyi Zhou wrote:
>>> On Tue, Jan 17, 2023 at 8:15 AM Joel Fernandes <joel@joelfernandes.org> w=
rote:
>>>>=20
>>>> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
>>>>> Hi Zhouyi,
>>>>>=20
>>>>> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wro=
te:
>>>>>>=20
>>>>> [..]
>>>>>> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.or=
g> wrote:
>>>>>>>=20
>>>>>>> Hello,
>>>>>>> I am seeing -EBUSY returned a lot during torture_onoff() when runnin=
g
>>>>>>> rcutorture on arm64. This causes hotplug failure 30% of the time. I a=
m
>>>>>>> also seeing this in 6.1-rc kernels. I believe see this only for CPU0=
.
>>>>>>>=20
>>>>>>> This causes warnings in torture tests:
>>>>>>> [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: err=
no -16
>>>>>>> [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: err=
no -16
>>>>>>>=20
>>>>>>> Full kernel log here:
>>>>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linu=
x-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.=
11/TREE04/console.log
>>>>>>>=20
>>>>>>> Any ideas on why this is happening and only for CPU 0 (presumably th=
e
>>>>>>> boot CPU)? I'd personally need these warnings to go away for my test=
s
>>>>>>> as this causes rcutorture's tests to not cleanly pass for me. It
>>>>>>> appears remove_cpu() -> device_offline() is what returns the error.
>>>>>>>=20
>>>>>> I guess this probably because CPU 0 is the tick_do_timer_cpu in
>>>>>> nohz_full mode, which prevent that cpu from
>>>>>> going offline [1]. We have discussed this topic, but there is no
>>>>>> agreement on how to solve it yet.
>>>>>=20
>>>>> But I am seeing the issue in TRACE02 config which is:
>>>>> CONFIG_NO_HZ_IDLE=3Dy
>>>>> # CONFIG_NO_HZ_FULL is not set
>>>>>=20
>>>>> So that is not NO_HZ_FULL:
>>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-=
5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11=
/TRACE02/console.log.diags/
>>>>> However, I can't seem to find the full kernel logs for that.
>>>>>=20
>>>>> Also, other than the TRACE02 fail, I only see the issue with configs
>>>>> with CONFIG_NO_HZ_FULL=3Dy
>>>>>=20
>>>>> Can you try TRACE02 specifically, and see if you can reproduce the
>>>>> same issue on your setup? Meanwhile, I'll try to trace what is
>>>>> returning the -EBUSY.
>>> I am trying TRACE02 on my X86_64 machine using cross compile and
>>> qemu-system-aarch64 now, my equipment is limited, but hope I can be of
>>> beneficial to the community ;-)
>>=20
>> Cool, I am assuming you are trying the patch you shared which you wrote i=
n
>> November. I bet you will still see the issue.
> yes, I still see the issue with no hz full.
>>=20
>>>>=20
>>>> How about something simple like the following? (untested)
>>>>=20
>>>> ---8<-----------------------
>>>>=20
>>>> diff --git a/kernel/torture.c b/kernel/torture.c
>>>> index bc8fb361efc0..cd64110694c0 100644
>>>> --- a/kernel/torture.c
>>>> +++ b/kernel/torture.c
>>>> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts=
, long *n_offl_successes,
>>>>                        // PCI probe frequently disables hotplug during b=
oot.
>>>>                        (*n_offl_attempts)--;
>>>>                        s =3D " (-EBUSY forgiven during boot)";
>>>> +               } else if (tick_nohz_full_running && ret =3D=3D -EBUSY)=
 {
>>>> +                       (*n_offl_attempts)--;
>>>> +                       s =3D " (-EBUSY forgiven if nohz_full is runnin=
g)";
>>> Fantastic fix!! thus we can fix the time keeper cpu torture problem
>>> without touch the time keeper code.
>>=20
>> Thanks. Unfortunately this does not fix the issue for TRACE02 and the pat=
ch
>> you shared does not fix it either -- because TRACE02 is not a no-hz-full
>> test. :-(
>>=20
>> We will need to do a bit of tracing to figure out where the -EBUSY is com=
ing
>> from for TRACE02.
> agree TRACE02 is another issue, unfortunately I can't reproduce the
> bug neither with your original Image [1]
> nor with my cross compiled kernel using [2].
>=20
> I guess there may be two reasons:
> 1) my testbed is X86_64 based.
> 2) the command that I invoke qemu is not right:
> 2-1) the newly compiled linux-5.15.89-rc1
> qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic -smp 4

Does 8 CPUs make any difference? That is my setup.

Not sure what else is different. It could be a CPU model specific issue, or s=
omething. But why donot you just use the same setup you used in November and=
 check TRACE02? That is actually what I was requesting you to rest, since yo=
u saw the same issue on that setup.

Thanks,

Joel=20



> -serial file:/tmp/consoleJan1702.log  -kernel arch/arm64/boot/Image
> -append "console=3DttyAMA0 oops=3Dpanic panic_on_warn=3D1 panic=3D-1
> ftrace_dump_on_oops=3Dorig_cpu debug earlyprintk=3Dserial slub_debug=3DUZ
> rcutorture.torture_type=3Dtasks-tracing rcutorture.onoff_interval=3D1000
> rcutorture.onoff_holdoff=3D1000 rcutorture.n_barrier_cbs=3D4
> rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D1200
> test_no_idle_hz=3D1 verbose=3D1" -m 2048 -net user,hostfwd=3Dtcp::10024-:2=
2
> -net nic
> 2-2) original Image [1]
> qemu-system-aarch64 -machine virt   -cpu cortex-a57   -nographic -smp
> 4  -serial file:/tmp/consoleJan1701.log   -kernel /home/zzy/Image
> -append "console=3DttyAMA0  oops=3Dpanic panic_on_warn=3D1 panic=3D-1
> ftrace_dump_on_oops=3Dorig_cpu debug earlyprintk=3Dserial slub_debug=3DUZ
> rcutorture.torture_type=3Dtasks-tracing rcutorture.onoff_interval=3D1000
> rcutorture.onoff_holdoff=3D30 n_barrier_cbs=3D4
> rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D1200
> test_no_idle_hz=3D1 verbose=3D1"   -m 2048   -net
> user,hostfwd=3Dtcp::10023-:22 -net nic
>=20
> As Mark can reproduce the issue using [1], there must be something
> wrong with my x86_64 based environment.
>=20
> Sorry not to be of help this time.
>=20
> I am very happy and interested to perform further tests whenever there
> are further instructions ;-)
>=20
> [1] http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-=
5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11=
/TRACE02/Image
> [2] http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-=
5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11=
/TRACE02/.config
>>=20
>> I wonder if we should ignore -EBUSY altogether, since as Thomas mentioned=
,
>> hotplug failure is "normal". Thoughts?
> This decision is too important for a beginner like me, however may
> thanks for your trust in me ;-) What does Paul think about it ;-)
>=20
> Thanks
> Zhouyi
>>=20
>> thanks,
>>=20
>> - Joel
>>=20
