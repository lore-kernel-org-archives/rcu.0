Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91606C55189
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70176206EC
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 13:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ql2EIoNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgDVNSp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgDVNSp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Apr 2020 09:18:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC7BC03C1A9
        for <rcu@vger.kernel.org>; Wed, 22 Apr 2020 06:18:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j4so2224265qkc.11
        for <rcu@vger.kernel.org>; Wed, 22 Apr 2020 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=uchh9xZf9elSlIgf8Xxf4XgRxCWvLtd9mt90C/GbGKg=;
        b=ql2EIoNR+wWfIzQqBbJJMFPRgg1I0z70qU2JcyGqtAgtrsN3U0iw4FYi6X2pU7se/K
         RAyLat+RwH++zLGUGmwvJK130fMtCjZPMzM6bnPHR09d1U6W0QLEg2TqYoRH8n5ci73a
         i/zlJs2qlo5eEHz9bcOsasJBkqIoRxjTYi+Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=uchh9xZf9elSlIgf8Xxf4XgRxCWvLtd9mt90C/GbGKg=;
        b=oSw2jIC/biXehjzA502J5QZxdJBGAYEPNlJ4VA7MgMHsiVzLEkNTxNW4UQDc1XeyI+
         so31Znm10vk69XuQjwQKimfvIuGP+C0sEMYIj2Fr33delgDjH51WwwR/deEn/LHMj4Ky
         S84EVhKqyYoQm5JM5FDZLDnE0d9roBbuDk60a4BeQtPxADo4Di4mZ1XdkmMxQIn62VYv
         DtSgdwGANW/ukfl+Ei8AuQVh92A1hnB5y+lee9rrkIzOpbHfu5wS2Fgj96mUV4i3rzgI
         d+thh5+MGvr0CfItmUuihJmiqQmyGRH2wQehiJR0ArSC0ygL2gQkj0rmVNDMZ5Cj0k95
         DPqg==
X-Gm-Message-State: AGi0PuZffNgTMQddL05rrrBWwAqJNWStqNei6EVeWcz1FnzBcPC+p192
        YnxTKxKCFrrNBY1EYUvvWVg76g==
X-Google-Smtp-Source: APiQypLAlOSp3e1LCS2yhCsQezJ74j5DgG7VCqGuCgfEutqf61Ct1fSw7UOLdAF4jQoY9VZq2OPb/A==
X-Received: by 2002:a05:620a:2013:: with SMTP id c19mr26427324qka.162.1587561523779;
        Wed, 22 Apr 2020 06:18:43 -0700 (PDT)
Received: from [192.168.1.17] (c-71-62-121-229.hsd1.va.comcast.net. [71.62.121.229])
        by smtp.gmail.com with ESMTPSA id p202sm3773299qke.120.2020.04.22.06.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 06:18:43 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:18:41 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20200422103536.GA16263@pc636>
References: <20200420153837.194532-1-joel@joelfernandes.org> <20200420153837.194532-3-joel@joelfernandes.org> <20200422103536.GA16263@pc636>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH rcu/dev -fixes 2/4] rcu/tree: Skip entry into the page allocator for PREEMPT_RT
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
From:   joel@joelfernandes.org
Message-ID: <51A69C78-FDD4-4A15-8969-EEA17CBA5BBD@joelfernandes.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On April 22, 2020 6:35:36 AM EDT, Uladzislau Rezki <urezki@gmail=2Ecom> wr=
ote:
>On Mon, Apr 20, 2020 at 11:38:35AM -0400, Joel Fernandes (Google)
>wrote:
>> To keep kfree_rcu() path working on raw non-preemptible sections,
>> prevent the optional entry into the allocator as it uses sleeping
>locks=2E
>> In fact, even if the caller of kfree_rcu() is preemptible, this path
>> still is not, as krcp->lock is a raw spinlock as done in previous
>> patches=2E With additional page pre-allocation in the works, hitting
>this
>> return is going to be much less likely soon so just prevent it for
>now
>> so that PREEMPT_RT does not break=2E Note that page allocation here is
>an
>> optimization and skipping it still makes kfree_rcu() work=2E
>>=20
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix=2Ede>
>> Co-developed-by: Uladzislau Rezki <urezki@gmail=2Ecom>
>> Signed-off-by: Uladzislau Rezki <urezki@gmail=2Ecom>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes=2Eorg>
>> ---
>>  kernel/rcu/tree=2Ec | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>=20
>> diff --git a/kernel/rcu/tree=2Ec b/kernel/rcu/tree=2Ec
>> index cf68d3d9f5b81=2E=2Ecd61649e1b001 100644
>> --- a/kernel/rcu/tree=2Ec
>> +++ b/kernel/rcu/tree=2Ec
>> @@ -3092,6 +3092,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct
>kfree_rcu_cpu *krcp,
>>  		if (!bnode) {
>>  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
>> =20
>> +			/*
>> +			 * To keep this path working on raw non-preemptible
>> +			 * sections, prevent the optional entry into the
>> +			 * allocator as it uses sleeping locks=2E In fact, even
>> +			 * if the caller of kfree_rcu() is preemptible, this
>> +			 * path still is not, as krcp->lock is a raw spinlock=2E
>> +			 * With additional page pre-allocation in the works,
>> +			 * hitting this return is going to be much less likely=2E
>> +			 */
>> +			if (IS_ENABLED(CONFIG_PREEMPT_RT))
>> +				return false;
>> +
>>  			bnode =3D (struct kfree_rcu_bulk_data *)
>>  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
>>  		}
>This will not be correctly working by just reverting everything to the
>"rcu_head path" for CONFIG_PREEMPT_RT kernel=2E We need to preallocate at
>least once=2E I can add caching on top of this series to address it=2E
>

I discussed with Vlad offline, this patch is fine for mainline as we don't=
 have headless support yet=2E So this patch is good=2E Future patches addin=
g caching will also add the headless support after additional caching, so s=
kipping the allocation here is ok=2E

Thanks=2E

- Joel




>--
>Vlad Rezki

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
