Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E64E137931
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747850; cv=none; b=eLNXJ5fc/oAZZX8h95jE4wYEmIfRUfJ0p2qvGxsbUchVJqaPuAlQF39pxfuA3teFP6nqjFtzjVa+xnn9HBM8jhprctlIVPXbIVZg7dBNwVbUmsFfrfb0CDEw9SeURHQ7BLHXtfaTBAD8JeJ/23AqAQd4pcFKQTnCtq8zkkmImRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747850; c=relaxed/simple;
	bh=DoLZ73UQ2sYr922EjiFb/8hKJ/WS5OtlQihqq3Ilgks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSCZHWoVGv3cT/Ab0tnty4wkwlwDZKpxrAGwsr/sS2rfudMSvTYWPNHMGAyu5OF5ot9+exth3aGhSD0MNg/xmL5NcWdW7moefyWsMQgf9BwziD2tiLEpEXVUKtvYzycGgcChBSbGg2zrOG/XL/rZJO5Scnre0FFczq+dHR9ZXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=OVO+pVEx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OVO+pVEx"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7883e1e01daso1891885a.3
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709747848; x=1710352648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxvsCK9smmdnLvgdOu7MnGblD5Q3xTi7tR97NRw7gKg=;
        b=OVO+pVExAxY1bM9+5hREGAwF86HaujtYA0evK8xlQMfLwjb/cAZqhG7wjpPzNpuYJk
         dobuQ1WoddvHZcr+xRDyIaTdM73vRE0BGgGA8KAZE8KSHLp11zmfKMQEvTLKyQ3VvJkA
         T9wp0tqHXkTPedv0lf1DV4CGZfUjM94TOCfYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709747848; x=1710352648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxvsCK9smmdnLvgdOu7MnGblD5Q3xTi7tR97NRw7gKg=;
        b=N4ngLVHLPJ9Zw2LMDIAIRglXhxgZL0lzDksmf+VxveD8WBo7mDIObBQL7pKkI29MZt
         RxAlS1QtSyp4GIV/7YvhzRaUWnqaiTOF3KQ6XMOoh4KkSNnuzIL2FUIdZo9TlLrH3O6S
         tXvueEQbwzLoDBhRVd+wLVXZg2UHagJLwTbjIvsLjAK9vq12kANtwLWeQtFpSj3wguyL
         SqCZ1QEDXj/weDXGgetQuDAfAHlpsUO7AO6awQly2ZdWpnBmdu6ZpAb5Ka3Dt3MhBamh
         w2aXDHAfjdEsTObb5buT0hDR5pe/F+orzGgID3BldEhb5lzcUrpe8Q5YF9IsOLfnX3Ja
         /nQg==
X-Forwarded-Encrypted: i=1; AJvYcCWVjCOTbsNYxy9SP8MIycoMLpXFe4sen8mo8PYbJITrtLjE3wTgzifrYqdNLqkzRRRBVgH4pJ0RuVtMOWQgWmYA1s/E
X-Gm-Message-State: AOJu0YwtCRnTsnhwLYKcoKMg1kz7JIoF3LsqFbS2Vp9qJjUZ0J15fMFs
	tDeAlVce/n4FtFt+3qJyF8VSPAfWQLu3BrhMHlBcyeoi4wt05pFa5aPi2W02vVNQxPnBFDRFUR5
	C
X-Google-Smtp-Source: AGHT+IHZ/f852118jg9L107pjZpuQhswgcnlCoZ5h6KU543SroWPfn4eMaDEOJNVNfW29yzzJ2cQbQ==
X-Received: by 2002:ae9:f709:0:b0:788:2ab7:2a62 with SMTP id s9-20020ae9f709000000b007882ab72a62mr5216638qkg.77.1709747847911;
        Wed, 06 Mar 2024 09:57:27 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b007882b4cecf8sm3123212qkb.57.2024.03.06.09.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 09:57:27 -0800 (PST)
Message-ID: <ae0475d7-fcfa-4d6f-9bb0-03479e6bf83b@joelfernandes.org>
Date: Wed, 6 Mar 2024 12:57:25 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>, Z qiang <qiang.zhang1211@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng
 <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20240305195720.42687-1-urezki@gmail.com>
 <20240305195720.42687-2-urezki@gmail.com>
 <CALm+0cWiOfKR=Gci0dj=z4gT4vSbZ=ZzMfo+CxLZCFQzL1bjfQ@mail.gmail.com>
 <ZehZ7Ef3DW2mT9fc@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZehZ7Ef3DW2mT9fc@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/2024 6:56 AM, Uladzislau Rezki wrote:
> On Wed, Mar 06, 2024 at 10:15:44AM +0800, Z qiang wrote:
>>>
>>> synchronize_rcu() users have to be processed regardless
>>> of memory pressure so our private WQ needs to have at least
>>> one execution context what WQ_MEM_RECLAIM flag guarantees.
>>>
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>> ---
>>>  kernel/rcu/tree.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 475647620b12..59881a68dd26 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1581,6 +1581,7 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>>>  /* Disabled by default. */
>>>  static int rcu_normal_wake_from_gp;
>>>  module_param(rcu_normal_wake_from_gp, int, 0644);
>>> +static struct workqueue_struct *sync_wq;
>>>
>>>  static void rcu_sr_normal_complete(struct llist_node *node)
>>>  {
>>> @@ -1679,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>          * of outstanding users(if still left) and releasing wait-heads
>>>          * added by rcu_sr_normal_gp_init() call.
>>>          */
>>> -       queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>>> +       queue_work(sync_wq, &rcu_state.srs_cleanup_work);
>>>  }
>>>
>>>  /*
>>> @@ -5584,6 +5585,9 @@ void __init rcu_init(void)
>>>         rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
>>>         WARN_ON(!rcu_gp_wq);
>>>
>>> +       sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
>>
>> Why was WQ_HIGHPRI removed?
>>
> I would like to check perf. figures with it and send out it as a
> separate patch if it is worth it.

I guess one thing to note is that there are also other RCU-related WQ which have
WQ_MEM_RECLAIM but not WQ_HIGHPRI (such as for expedited RCU, at least some
configs). So for consistency, this makes sense to me.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org).

thanks,

 - Joel
