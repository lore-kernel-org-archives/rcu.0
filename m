Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E1BC63797
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 04:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjAQEhO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjAQEhM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 23:37:12 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344822DE1
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 20:37:09 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id g10so15397075qvo.6
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 20:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLoQqZftjnCUwoVwY/otN5J+xXXtSAEG0Ia5kJyv5is=;
        b=DbWtKnmz7z/eKHils5xt7TFp0YCRMJ5eukHDFt0Mf+VeDp+zfDko9h36HOmlD4jf8S
         DB879IwgJPIo0HTOFeL/q7Ld7GjJjv+ChCMATNgmL/uqtPnn2MLimgwy7rsoYShVfhKn
         NXlgeujnOTgtpHEZI/h6rmixvqQamxmfaxwms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLoQqZftjnCUwoVwY/otN5J+xXXtSAEG0Ia5kJyv5is=;
        b=JxxmwCQgAUUFEyKgZ799qsJzvrGlzatmR0ZRXfDnA4KayMvQUWQ6C+OzZNVMdsjMAc
         b2WWgJldihbC44WnlcEPxYTIKc0OuNJfcjrG2gIZJj5TK3UrL1mL1vOazn6PE19/4DmB
         stWga8uE8SOgaL8eUpwSpb9QMYUaQgshKsvq32QEbyPXqo/6QUyGrFGnTduB1AktwVlS
         K7ZWnCigytXwwTs8p3UeRQCIYEBRwqjQ+vSoPmaDx57e9nER7y1cax8VqkyZ3IDJ6PgB
         FNiCawQCW1ojipapgGpZIcxFos4fQ5bp4QLrdstlfVPS0a+0F2CItaUs+cg5fIJNfqsM
         1XgQ==
X-Gm-Message-State: AFqh2kpwo4GBRpXtxQ6Sd/qMnZ1IIZzK0MS8lqeF2q77OwcIiNg2KZD3
        5ocOo8/ld0IpKO6++cmOpQClD3PKTwSBWGFA
X-Google-Smtp-Source: AMrXdXslF2ts6snNhfbUQm6tDuW0tQacUplK59BQzscE6ab+Y8YuPnIJZo86wULF9MsfC9yOKf1XhA==
X-Received: by 2002:a05:6214:e8e:b0:4ed:fb72:9186 with SMTP id hf14-20020a0562140e8e00b004edfb729186mr4742289qvb.0.1673930228896;
        Mon, 16 Jan 2023 20:37:08 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id d3-20020ae9ef03000000b00705e0ad29cdsm11301693qkg.77.2023.01.16.20.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 20:37:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Date:   Mon, 16 Jan 2023 23:36:57 -0500
Message-Id: <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org>
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>
In-Reply-To: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 16, 2023, at 11:30 PM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Tue, Jan 17, 2023 at 12:15:07AM +0000, Joel Fernandes wrote:
>>> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
>>> Hi Zhouyi,
>>>=20
>>> On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote=
:
>>>>=20
>>> [..]
>>>> On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>>>>>=20
>>>>> Hello,
>>>>> I am seeing -EBUSY returned a lot during torture_onoff() when running
>>>>> rcutorture on arm64. This causes hotplug failure 30% of the time. I am=

>>>>> also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
>>>>>=20
>>>>> This causes warnings in torture tests:
>>>>> [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno=
 -16
>>>>> [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno=
 -16
>>>>>=20
>>>>> Full kernel log here:
>>>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-=
5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11=
/TREE04/console.log
>>>>>=20
>>>>> Any ideas on why this is happening and only for CPU 0 (presumably the
>>>>> boot CPU)? I'd personally need these warnings to go away for my tests
>>>>> as this causes rcutorture's tests to not cleanly pass for me. It
>>>>> appears remove_cpu() -> device_offline() is what returns the error.
>>>>>=20
>>>> I guess this probably because CPU 0 is the tick_do_timer_cpu in
>>>> nohz_full mode, which prevent that cpu from
>>>> going offline [1]. We have discussed this topic, but there is no
>>>> agreement on how to solve it yet.
>>>=20
>>> But I am seeing the issue in TRACE02 config which is:
>>> CONFIG_NO_HZ_IDLE=3Dy
>>> # CONFIG_NO_HZ_FULL is not set
>>>=20
>>> So that is not NO_HZ_FULL:
>>> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.=
15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/T=
RACE02/console.log.diags/
>>> However, I can't seem to find the full kernel logs for that.
>>>=20
>>> Also, other than the TRACE02 fail, I only see the issue with configs
>>> with CONFIG_NO_HZ_FULL=3Dy
>>>=20
>>> Can you try TRACE02 specifically, and see if you can reproduce the
>>> same issue on your setup? Meanwhile, I'll try to trace what is
>>> returning the -EBUSY.
>>=20
>> How about something simple like the following? (untested)
>>=20
>> ---8<-----------------------
>>=20
>> diff --git a/kernel/torture.c b/kernel/torture.c
>> index bc8fb361efc0..cd64110694c0 100644
>> --- a/kernel/torture.c
>> +++ b/kernel/torture.c
>> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, l=
ong *n_offl_successes,
>>            // PCI probe frequently disables hotplug during boot.
>>            (*n_offl_attempts)--;
>>            s =3D " (-EBUSY forgiven during boot)";
>> +        } else if (tick_nohz_full_running && ret =3D=3D -EBUSY) {
>> +            (*n_offl_attempts)--;
>> +            s =3D " (-EBUSY forgiven if nohz_full is running)";
>=20
> But this should be forgiven for the timekeeping CPU, not everyone,
> correct?
>=20
> Yes, I know that CPU-hotplug operations can fail, but in my testing
> they almost never do.  This means that a new failure might well be a
> real bug somewhere that needs attention.

Sure. We may need to expose some API to reveal that.=20

It appeared though that Thomas in the other thread related to patch from Zho=
uyi, was suggesting that rcutorture tolerate hotplug failure though, because=
 they are not abnormal, right?

Thanks,

 - Joel


>=20
>                            Thanx, Paul
>=20
>>        }
>>        if (verbose)
>>            pr_alert("%s" TORTURE_FLAG
