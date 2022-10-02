Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDFAC433F5
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 16:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJBQLT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJBQLL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 12:11:11 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5E729C9B
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 09:11:10 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id i12so5777742qvs.2
        for <rcu@vger.kernel.org>; Sun, 02 Oct 2022 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hR17EXq59DngnHird0rmVVQebUo6VsyImHDLUqZ7FFU=;
        b=Fs9Y1d60NN5fBk2oGzzWBWoBorSfdPV7GYenSeBpD33ja89QCjE2rmYHMj+S2/q9j1
         5zuXmBOcG5LexN9LReOL7WVjvjbCgkLHvtCSIgQ7l1WNnlSlIhU90F1Noc/qX6ugGu0n
         NbC+5/VasDCto1CMWUipAJA5Fv3yEjtTEyntQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hR17EXq59DngnHird0rmVVQebUo6VsyImHDLUqZ7FFU=;
        b=BCaM503MPWK7JFNOLSMbmO8BMJWehm1bsfDzSm+O4GRE7NlYhEWG4475rJV8ZYxLC0
         I53akAM5fqapO2UWZDrxjS5oJB1BucKf81zuYIuDu+pZHCJ1X9+pWEZXjdqg6J7ynZDO
         jQDk4PmC7f8day0LUgP9zolOGU849aMV+UC2Ja/lwazshiecOkeUIgwK5TenT4iEPgVX
         HRM/7pDrnU9k6I9m/wmVQw3QNIJamSdhbjd2MhiWYOBOBODIG7jGg1MlytzLi9KcHuUH
         bg2bOZ4qgslbg+TlFfqlAA9FX27TY7D5zhdm+sH0pi+jYQiVyOE5BeRUQkxTznH1VVVQ
         +G+Q==
X-Gm-Message-State: ACrzQf0pw6bug13h8QkMncUseC/p1bmqd9f/npjSxj+wLd1aoWVVAHQN
        PozuMS25w6M5GHis3+5KDiwCAQ==
X-Google-Smtp-Source: AMsMyM5rpjAjfEqTuMSO6fIeGZldyQD8HbdJJy9dmomLMCSB2YYWO3t3xXXPVvrqWwlbd2F4MM7kgw==
X-Received: by 2002:a05:6214:19e7:b0:4aa:216f:5ab5 with SMTP id q7-20020a05621419e700b004aa216f5ab5mr13636733qvc.66.1664727069142;
        Sun, 02 Oct 2022 09:11:09 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id d5-20020ac84e25000000b0034355bb11f2sm7055289qtw.10.2022.10.02.09.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:11:08 -0700 (PDT)
Message-ID: <552a3507-7d34-70d9-d882-3efed6f7e027@joelfernandes.org>
Date:   Sun, 2 Oct 2022 12:11:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Content-Language: en-US
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen>
 <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
 <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com>
 <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
 <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <CAFgQCTu-oyFMQOSGc=9q_ni=hJQ87oxM0AAU1joftkX36t9ejw@mail.gmail.com>
 <CAEXW_YQ19C-Drh7zVDvGRj-zsdJzhpAUJJVvzA+6SHNbTJoA9w@mail.gmail.com>
 <CAFgQCTvDCVL57JR3XA8UWCaS6aL9RHf=Bit6U0DDF7fqBBangA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <CAFgQCTvDCVL57JR3XA8UWCaS6aL9RHf=Bit6U0DDF7fqBBangA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 10/2/2022 10:06 AM, Pingfan Liu wrote:
> On Fri, Sep 30, 2022 at 9:04 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> On Thu, Sep 29, 2022 at 4:21 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>>>
>>> On Thu, Sep 29, 2022 at 4:19 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>>>>
>>> [...]
>>>> "
>>>>
>>>> I have no idea whether this is related to the reverted commit.
>>>>
>>>
>>> I have started another test against clean v6.0-rc7 to see whether this
>>> is an issue with the mainline.
>>
>> I am not sure what exactly you are reverting (you could clarify that),
> 
> commit 96926686deab ("rcu: Make CPU-hotplug removal operations enable tick").
> But due to conflict, "git revert" can not work directly. So I applied
> it by hand.
> 
>> but if you are just removing the entire TICK_DEP_BIT_RCU, I do
>> remember (and mentioned on IRC to others recently) that without this
>> NOHZ_FULL has a hard time ending grace-periods because the forcing of
>> tick is needed for this configuration if we are spinning in the kernel
>> with the tick turned off. That seems to align with your TREE04
>> (NOHZ_FULL) configuration.
>>
> 
> Yes, that is the scenario.
> 
>> Also, the commit Frederic suggested to revert seems to be a cosmetic
>> optimization in the interrupt-entry path. That should not change
>> functionality I believe. So I did not fully follow why reverting that
>> is relevant (maybe Frederic can clarify?).
>>
> 
> Leave this question to Frederic.

I take this comment back, Sorry. Indeed the commits Frederic mentioned will make
a functional change to CPU hotplug path.

Sorry for the noise.

Excited to see exact reason why TICK_DEP_BIT_RCU matters in the hotplug paths. I
might jump into the investigation with you guys, but I have to make time for
Lazy-RCU v7 next :)

Thanks.
