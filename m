Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCAC4321E
	for <rcu@archiver.kernel.org>; Fri,  2 Dec 2022 13:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiLBNZ2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Dec 2022 08:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLBNZ1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Dec 2022 08:25:27 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A89087C81
        for <rcu@vger.kernel.org>; Fri,  2 Dec 2022 05:25:26 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cg5so4989799qtb.12
        for <rcu@vger.kernel.org>; Fri, 02 Dec 2022 05:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0AbfHPEywIA+i7OFl/ipuz3aIR2RkHnn2kAkqZ72ys=;
        b=TW+iximgJ0oL/SlYQ2fe8D6XdrISaaOwu8cy1iFARQav3L9StrWbkFzqjgJm634oP6
         rVCqNA+R2Sov9mhfsin6mmnZEfApcXHr7i+63T8L5dBnFQTuWkCF3aD9//DMqlSSu5qB
         ZTizvpRQGKqAWhHx/NLf+Ru8R/48fTQSJLkGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0AbfHPEywIA+i7OFl/ipuz3aIR2RkHnn2kAkqZ72ys=;
        b=JD1+XXJ+nUuORq63OTx8bSbRK+Pvxmi/AMK5wonPfb5KPdN1Dw3KU4jc8uhvQFtrzt
         uhgw5FBlCvoSwFgYhD8vu+Dxmdu7yMiNtS1G/8uRTr1PBN6osN1ipa+VUU6Us33tLtH0
         8JKX07liae04ZCPTtHax+pG7PYqg/5yJhWAV1Pp+YqNphBUgTdP2Sr93v+gBXUnwsyrV
         NCCWplCg2twgPS3kjpNvEPjAOzppV/WO5P7519KCLuU6U6C4ssWfSC4F/BuOU3PSTrgT
         k+R/dO/na1ybt3j64LilN5rVgrchFKJl6NX7B6K99jfG92KiJidwWX7lFO7HAXpBawte
         8uHQ==
X-Gm-Message-State: ANoB5plEBCezPy3zQDwYP1eEgH3I0af4aUtdL4hwevXp8HWYhijZB5s+
        2On101RnNO2+xQKXy2WfKcTuFi0Y09Lzg7dArVI=
X-Google-Smtp-Source: AA0mqf71uEGmxIoIYJ/40kP+aU4bJMdD+QvwF5wEyZ4734MQkAs53+dpzDK5uETo8/ati2e6P5yEOA==
X-Received: by 2002:a05:622a:1c1a:b0:3a6:5699:2ad3 with SMTP id bq26-20020a05622a1c1a00b003a656992ad3mr45733934qtb.12.1669987525239;
        Fri, 02 Dec 2022 05:25:25 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bm8-20020a05620a198800b006fa8299b4d5sm5519887qkb.100.2022.12.02.05.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 05:25:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Fri, 2 Dec 2022 08:25:13 -0500
Message-Id: <6AC29795-0292-4FE9-9167-13122C08CD96@joelfernandes.org>
References: <PH0PR11MB58800E4DF4BF0B60FBFC71E2DA179@PH0PR11MB5880.namprd11.prod.outlook.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <PH0PR11MB58800E4DF4BF0B60FBFC71E2DA179@PH0PR11MB5880.namprd11.prod.outlook.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 2, 2022, at 7:52 AM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Dec 01, 2022 at 07:45:33AM +0800, Zqiang wrote:
>> Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
>> RCU-tasks grace period, if __num_online_cpus =3D=3D 1, will return
>> directly, indicates the end of the rude RCU-task grace period.
>> suppose the system has two cpus, consider the following scenario:
>>=20
>>        CPU0                                   CPU1 (going offline)
>>                                          migration/1 task:
>>                                      cpu_stopper_thread
>>                                       -> take_cpu_down
>>                                          -> _cpu_disable
>>                                           (dec __num_online_cpus)
>>                                          ->cpuhp_invoke_callback
>>                                                preempt_disable
>>                                                access old_data0
>>           task1
>> del old_data0                                  .....
>> synchronize_rcu_tasks_rude()
>> task1 schedule out
>> ....
>> task2 schedule in
>> rcu_tasks_rude_wait_gp()
>>     ->__num_online_cpus =3D=3D 1
>>       ->return
>> ....
>> task1 schedule in
>> ->free old_data0
>>                                                preempt_enable
>>=20
>> when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
>> the CPU1 has not finished offline, stop_machine task(migration/1)
>> still running on CPU1, maybe still accessing 'old_data0', but the
>> 'old_data0' has freed on CPU0.
>>=20
>> In order to prevent the above scenario from happening, this commit
>> remove check for __num_online_cpus =3D=3D 0 and add handling of calling
>> synchronize_rcu_tasks_generic() during early boot(when the
>> rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE, the scheduler
>> not yet initialized and only one boot-CPU online).
>>=20
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>=20
>> Very good, thank you!  I did the usual wordsmithing, including to that
>> error message, so as usual please check to make sure that I didn't mess
>> something up.
>>=20
>>                            Thanx, Paul
>>=20
>> ------------------------------------------------------------------------
>>=20
>> commit 033ddc5d337984e20b9d49c8af4faa4689727626
>> Author: Zqiang <qiang1.zhang@intel.com>
>> Date:   Thu Dec 1 07:45:33 2022 +0800
>>=20
>>   rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
>>=20
>>   The synchronize_rcu_tasks_rude() function invokes rcu_tasks_rude_wait_g=
p()
>>   to wait one rude RCU-tasks grace period.  The rcu_tasks_rude_wait_gp()
>>   function in turn checks if there is only a single online CPU.  If so, i=
t
>>   will immediately return, because a call to synchronize_rcu_tasks_rude()=

>>   is by definition a grace period on a single-CPU system.  (We could
>>   have blocked!)
>>=20
>>   Unfortunately, this check uses num_online_cpus() without synchronizatio=
n,
>>   which can result in too-short grace periods.  To see this, consider the=

>>   following scenario:
>>=20
>>           CPU0                                   CPU1 (going offline)
>>                                             migration/1 task:
>>                                         cpu_stopper_thread
>>                                          -> take_cpu_down
>>                                             -> _cpu_disable
>>                                              (dec __num_online_cpus)
>>                                            ->cpuhp_invoke_callback
>>                                                   preempt_disable
>>                                                   access old_data0
>>              task1
>>    del old_data0                                  .....
>>    synchronize_rcu_tasks_rude()
>>    task1 schedule out
>>    ....
>>    task2 schedule in
>>    rcu_tasks_rude_wait_gp()
>>        ->__num_online_cpus =3D=3D 1
>>          ->return
>>    ....
>>    task1 schedule in
>>    ->free old_data0
>>                                                   preempt_enable
>>=20
>>   When CPU1 decrements __num_online_cpus, its value becomes 1.  However,
>>   CPU1 has not finished going offline, and will take one last trip throug=
h
>>   the scheduler and the idle loop before it actually stops executing
>>   instructions.  Because synchronize_rcu_tasks_rude() is mostly used for
>>   tracing, and because both the scheduler and the idle loop can be traced=
,
>>   this means that CPU0's prematurely ended grace period might disrupt the=

>>   tracing on CPU1.  Given that this disruption might include CPU1 executi=
ng
>>   instructions in memory that was just now freed (and maybe reallocated),=

>>   this is a matter of some concern.
>>=20
>>   This commit therefore removes that problematic single-CPU check from th=
e
>>   rcu_tasks_rude_wait_gp() function.  This dispenses with the single-CPU
>>   optimization, but there is no evidence indicating that this optimizatio=
n
>>   is important.  In addition, synchronize_rcu_tasks_generic() contains a
>>   similar optimization (albeit only for early boot), which also splats.
>>   (As in exactly why are you invoking synchronize_rcu_tasks_rude() so
>>   early in boot, anyway???)
>>=20
>>   It is OK for the synchronize_rcu_tasks_rude() function's check to be
>>   unsynchronized because the only times that this check can evaluate to
>>   true is when there is only a single CPU running with preemption
>>   disabled.
>>=20
>>   While in the area, this commit also fixes a minor bug in which a
>>   call to synchronize_rcu_tasks_rude() would instead be attributed to
>>   synchronize_rcu_tasks().
>>=20
>>   [ paulmck: Add "synchronize_" prefix and "()" suffix. ]
>>=20
>>   Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>   Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>=20
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index 4dda8e6e5707f..d845723c1af41 100644
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>> static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
>> {
>>    /* Complain if the scheduler has not started.  */
>> -    WARN_ONCE(rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE,
>> -             "synchronize_rcu_tasks called too soon");
>> +    if (WARN_ONCE(rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE,
>> +             "synchronize_%s() called too soon", rtp->name))
>=20
> Thanks Paul,  detailed description and modification =F0=9F=98=8A.

True statement. Good example for everyone ;-)

 - Joel


>=20
>=20
>> +        return;
>>=20
>>    // If the grace-period kthread is running, use it.
>>    if (READ_ONCE(rtp->kthread_ptr)) {
>> @@ -1064,9 +1065,6 @@ static void rcu_tasks_be_rude(struct work_struct *w=
ork)
>> // Wait for one rude RCU-tasks grace period.
>> static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>> {
>> -    if (num_online_cpus() <=3D 1)
>> -        return;    // Fastpath for only one CPU.
>> -
>>    rtp->n_ipis +=3D cpumask_weight(cpu_online_mask);
>>    schedule_on_each_cpu(rcu_tasks_be_rude);
>> }
