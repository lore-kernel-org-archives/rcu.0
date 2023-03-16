Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E95CC6FD1F
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 18:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCPSBs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Mar 2023 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCPSBq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Mar 2023 14:01:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A545B82A90
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 11:01:42 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s12so2693296qtq.11
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678989702;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCwCM3jwPSvdECvB/xV5I3zv9L1I+QhlBAmAlgtE4FQ=;
        b=op2+uxAWauOKpPTojx20BV5gxXCYlB8Lbx6xbjfTUyHuq7D75G1ELi7NtzO0KqDZjz
         NuknRMcdtn0iNP4XSB26lQ7nz0Ie2KiPGhI+O5vpsadGCejjvwtd+VfdOHa+ryLucJHI
         3TyHSfzK7C3/5HkwvVlijIo3W2dBppwkwBY54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989702;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCwCM3jwPSvdECvB/xV5I3zv9L1I+QhlBAmAlgtE4FQ=;
        b=sWj67eGb50Wn4uoE2sBfBXuBogSZoznMnwtB0agunLK4jBZtKuWxUMsJoXelSUgS4m
         IwPNTJuPFVvIbMwgNtmwLDVk83IaISCHGDCioro81ZyWC1DsXZirdhFHKdvmTWPvGJK5
         5tKwO5r/QG295WE81mdqOIK37lyAqgklV7KevFUTGRbv7D2cQ+E3UeRRP+SkNeNI3cs/
         CAqGC3+FG0UeFkl3gTkT7vBV9e47qlj+4og4Z4TM85f+E+6vpxgvX6z1yvgQPJVxdd50
         TsslOv7MhhgznbWi86gc32JKyqq8JL8ECRR826WZ1H039sCi/bZFT+0ttnj+s3LQwwmD
         S8vA==
X-Gm-Message-State: AO0yUKWf4PYoYK/A6x7HXd50if1+vS730V1M8PkLW8OK7jSMVV2F0Z8a
        an/M+MMXet9MczsLJtNkcRpSag==
X-Google-Smtp-Source: AK7set/aw9X62MklOWFG4KKNwzni4qAvByFnMghhs4OBsFtn6S+MCj3xw03rNNZCxBT/Nk102q3R8A==
X-Received: by 2002:ac8:5c4e:0:b0:3d9:218a:3390 with SMTP id j14-20020ac85c4e000000b003d9218a3390mr2392235qtj.8.1678989701653;
        Thu, 16 Mar 2023 11:01:41 -0700 (PDT)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id b17-20020ac86bd1000000b003bfd27755d7sm77156qtt.19.2023.03.16.11.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:01:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Thu, 16 Mar 2023 14:01:30 -0400
Message-Id: <70A3066E-3B61-4B81-B36D-69BC27DAD5E9@joelfernandes.org>
References: <ZBNYogVe9spBmTm2@pc636>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZBNYogVe9spBmTm2@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Mar 16, 2023, at 1:58 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, Mar 15, 2023 at 06:36:48PM -0400, Steven Rostedt wrote:
>> On Thu, 9 Mar 2023 14:45:21 +0100
>> Uladzislau Rezki <urezki@gmail.com> wrote:
>>=20
>>>> The kvfree_rcu()'s single argument name is deprecated therefore
>>>> rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
>>>> underline that it is for sleepable contexts.
>>>>=20
>>>> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>>=20
>>> Could you please add you reviwed-by or Acked-by tags so we can bring
>>> our series with renaming for the next merge window?
>>=20
>> I don't know. Perhaps we should just apply this patch and not worry about=

>> sleeping and whatnot.
>>=20
>> -- Steve
>>=20
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index 04f0fdae19a1..5de945a8f61d 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -76,6 +76,7 @@ static unsigned long osnoise_options    =3D OSN_DEFAULT=
_OPTIONS;
>> struct osnoise_instance {
>>    struct list_head    list;
>>    struct trace_array    *tr;
>> +    struct rcu_head        rcu;
>> };
>>=20
>> static struct list_head osnoise_instances;
>> @@ -159,7 +160,7 @@ static void osnoise_unregister_instance(struct trace_=
array *tr)
>>    if (!found)
>>        return;
>>=20
>> -    kvfree_rcu(inst);
>> +    kvfree_rcu(inst, rcu);
>> }
>>=20
>> /*
>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>> index 20d0c4a97633..ef5fafb40c76 100644
>> --- a/kernel/trace/trace_probe.c
>> +++ b/kernel/trace/trace_probe.c
>> @@ -1172,7 +1172,7 @@ int trace_probe_remove_file(struct trace_probe *tp,=

>>        return -ENOENT;
>>=20
>>    list_del_rcu(&link->list);
>> -    kvfree_rcu(link);
>> +    kvfree_rcu(link, rcu);
>>=20
>>    if (list_empty(&tp->event->files))
>>        trace_probe_clear_flag(tp, TP_FLAG_TRACE);
>> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
>> index ef8ed3b65d05..e6037752dcf0 100644
>> --- a/kernel/trace/trace_probe.h
>> +++ b/kernel/trace/trace_probe.h
>> @@ -256,6 +256,7 @@ struct trace_probe {
>> struct event_file_link {
>>    struct trace_event_file        *file;
>>    struct list_head        list;
>> +    struct rcu_head            rcu;
>> };
>>=20
>> static inline bool trace_probe_test_flag(struct trace_probe *tp,
>>=20
> Anyway i do not see any problems with it
>=20
> Acked-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Just to clarify, we are dropping the original patch and instead taking Steve=
s version?

If so, Steve please send a patch when you are able to and with Vlads Ack,
we can take it via the RCU tree if that is Ok with you.

Thanks,

 - Joel


>=20
> --
> Uladzislau Rezki
