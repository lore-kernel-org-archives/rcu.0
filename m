Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B84369D53
	for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821910; cv=none; b=k097xOhgntw96OGmWYfuJh3ze0tTnhLysOczee2uBMT+H0MDUmAcywmng2b6aZ8XQBklSUBbmjmjFnLOxb7a51DC6DDW19BBb0fEp9G1zBAK4/DDWwkhEC3nKfhJpmvfESbPZpdFigANFy1Su8DBD/omu99n4lIhmknYk+ziNWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821910; c=relaxed/simple;
	bh=UShlGlM7yf15Wa0oAMuYJOAACgtpp+GFjTVEVwTvaso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni6SlplglwSmul6pgjPdxPwTJn9hcn8jIhWMJ95GeZPhJrerl+7KRvjQLvd1XD7n6euSL9pI7gRR+J1SKBuNawdtJYEBh/ZBGEPOSA3i5gWOgcZOWQwWwROtZ1OdaWyOL6AYBh2i711AJ5lOldQj9TUjqlQoT57XSD4hL4loWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4eMOnbC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4eMOnbC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso2429613a91.0
        for <rcu@vger.kernel.org>; Thu, 27 Aug 2026 02:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787821908; x=1788426708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mg/h6fTjci5ec1PS11v10182m44lAJ1lV6itb9+QYfo=;
        b=V4eMOnbCCjJ08Sh6/9EkgRR+08DyJsdAFIxRHeAPlgD4ihpq+SvLS+vhtmgntLOKgy
         O3lUzV0iDrD5u4lVY2zEXmPQWB/UE5PColicHQfxLXXcnpIwwtpff4+ILNqNYrLrbaw+
         9DracsoAzHAmA6Z/+iHHlgJIcicodl91+txeXTU1uPIE0h2TrS+V+MII0jbVebjON7nm
         jaWlMNGGZ+PGGmtU2tRjcmO5P/2+ePvYE77ivsFtLfZD2MrgKymPQK2kdzQZsqJD9WRX
         ICINdbfWdOPnL01iT2j9rHddc39xOa4jl4IVt8Lla/YSMcaXc/2kejDxM9o39t6kCFh6
         zYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821908; x=1788426708;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mg/h6fTjci5ec1PS11v10182m44lAJ1lV6itb9+QYfo=;
        b=bclDvPFq2hJeKd8pgDUBXI4i9DRleEGtl5wSttVQFvV/xUDAMLMs8VZyTuLwrjmdjS
         uwPFcH55xDsfJGVVT+6w9H6istMJODTqlemc45arNu1I8gu/n2RXoD7NhAMgrrRX6YM9
         nZm6k2EIs48QNm+UnlknzcoeqO2SFTAB7dL9mp6EBRbMN8JeGfSGBPklQkJ6wk7GvBrk
         JUhz9zKlm/cIcPzWKlkkjSn3JlkE5aLcLPu78fxur5ZaoA/t/hIAKW47kLq+abB1Wlra
         LOt3TXpQQZrYu1Pd7g7vvXs/M51Tb1/JijZgyohRfAIqbBSY/htEaOE9wWqA9/SwCdhS
         h4kQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJWJ5RFAJGPURK5cO9VPo7jriSC7GO2jaX6tKm5tymeQ9rZL5JvAf0WrqfOA0JlpnJF38=@vger.kernel.org
X-Gm-Message-State: AFuF++kiE+4kY/EkV1dQSVc6nhri/F7r6dn+m/4V9B71G1AvZKzPeiQi
	kkGiWiOJrJhg8XA18yRDdVPH5wzDI8jOEeQdBJFxgK9AfRrt1O0YgLA6
X-Gm-Gg: AR+sD12S2tJEm3sKD00hlB40QpVWHvBGghumNQUr0xB6UoH7qSP3WSzuSqkRjGDNXrA
	ykd6QVVCXLwFrHF++X1yEJ+XO/NgJAI7u3wa6LJRppbUM9IQXQ2naGulLL1pKt3XGET2OsGyS6s
	aU1oiXBYiCnqWDmB25Uy0x1XTR9Vf7AXXBJ3sDi+oTYjXevyCUrsKTGvU9iN0hYN2w110nGgo/p
	fl/NTYT7rpgFz8Au1W39rf0BR4YgQrPCuLRd/LQR1S8oN9cQOXRZZDI6SFE3rZvSFqZmJeFm0LX
	QTf6umM5E0RRvzTLKL6bGrM8FXbKnHZu1rnQrnjFRd32iHWalUdXfsEE+BebrPhu1DWfL0on3oj
	KZ+v+9fI4OfCYenDbdzZtYQe9SktDqMBALFKitrQxBbTY2FeV49i5WO0f5jYfrlQFsGfwRu/YXy
	nRTK9re6xGPIJk6Ghj9PKYfvBGy9iZf9Z5sVZ4P4BJMYrN6rpE6XC6Yj8U7lTQbNewToZj
X-Received: by 2002:a17:90b:4c8e:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-3966d44daf1mr22284412a91.14.1787821908265;
        Thu, 27 Aug 2026 02:11:48 -0700 (PDT)
Received: from [192.168.55.196] ([218.49.81.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1992e05sm1959634a91.15.2026.08.27.02.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 02:11:47 -0700 (PDT)
Message-ID: <f85c60a0-81d7-41a4-9926-f69cf10222d0@gmail.com>
Date: Thu, 27 Aug 2026 18:11:45 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after
 78a38cbf6f20
To: Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
References: <20260824105625.3725157-1-shpark061104@gmail.com>
 <494f3e0cdb3692bf13690f4cddd3b40098b51627@linux.dev>
 <24c0edd6-3cdc-4536-ac78-394bf785aad4@gmail.com>
 <0e74e6799bf042293fd1e34e2f242c56786c3de4@linux.dev>
 <9e216978-d884-4d56-b39f-d134f78a4999@gmail.com>
 <eb2132ad05cd3804a8f2a170de441d79afa793e9@linux.dev>
Content-Language: en-US
From: Sunho Park <shpark061104@gmail.com>
In-Reply-To: <eb2132ad05cd3804a8f2a170de441d79afa793e9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/27/26 08:53, Zqiang wrote:
> Based on your description below, the 5.srcu_barrier() did not intercept the callback of 4.call_srcu(),
> this means that 4.call_srcu() and 5.srcu_barrier() concurrent calls, or calls after 5.srcu_barrier().
> 
> The combination of srcu_barrier() and cleanup_srcu_struct() typically occurs on the module exit path.
> srcu_barrier() ensures that all previously inserted callbacks complete，so therefore, theoretically,
> there shouldn't be any callbacks left to execute after we finish executing srcu_barrier().
> and of course, there are also shouldn't be any ongoing or newly started SRCU grace period and the
> WARN_ON() in cleanup_srcu_struct() is designed to detect it.
> 
> If when the cleanup_srcu_struct() detects an incomplete SRCU grace period or any srcu callbacks
> that have not yet been executed, this is a risk that needs to be reported, even if the
> cleanup_srcu_struct() can intercept it internally.
>   
> Therefore, we should investigate this issue to ensure that 5.srcu_barrier() can intercept the step 4 callback.
> 
> Thanks
> Zqiang

Before 5. srcu_barrier() call, the 4. call_srcu() is finished and the 
callback was enqueued, and srcu_barrier() did intercept it by appending 
barrier cb after it. They can't be called concurrently because when 
call_srcu() is called inside kvm_io_bus_register_dev(), the kvm 
reference count is nonzero and kvm_destroy_vm() which calls 
srcu_barrier() could not be started.

In my debugging, all five __free_bus() callbacks enqueued by 
kvm_io_bus_register_dev() were invoked before the barrier cb, and only 
then the barrier cb is called and srcu_barrier() returns. So all the 
real callbacks were executed and practically there were no callbacks 
left to execute when srcu_barrier() returns, but a stale n_cbs > 0 is 
left because srcu_invoke_callbacks()'s invoking loop has not finished.

KVM logic correctly called srcu_barrier() and cleanup_srcu_struct() 
without calling call_srcu() in between. In my opinion, the root causes 
are as follows:

1) for timer_delete_sync(): the srcu_gp_end() which ended the last grace 
period (from 4. ) arms sdp->delay_work to expire at jiffies + 1 even 
though the invoke work (queued in 3. ) is already queued, and 
cleanup_srcu_struct() runs before that one-jiffy timer expires, so 
timer_delete_sync() cancels that pending timer and returns true.

2) for n_cbs: srcu_invoke_callbacks() calls rcu_segcblist_add_len(-len) 
only at the end of the work item, after the barrier callback has been 
invoked and srcu_barrier() has already returned, so 
cleanup_srcu_struct() observes a stale n_cbs > 0 while the cblist is 
physically empty.

Thanks
Sunho Park
