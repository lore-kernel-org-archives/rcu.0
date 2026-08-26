Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABC392836
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760239; cv=none; b=ZrjVD2yLB09MGDVaTBGvTM7/AEbNLAF7Uunt9iubCXYjtAFf0KaBGaYh3T/VettIt1k+rt7zAylFkGasQ27Hzx/x8o6SVE1g0SPX23nmef6OFUduvEcbdff0fNQvDdQ25FsdeoAqHyjHxUsfmLaFOX4J+12OXx2nspDEZtnMeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760239; c=relaxed/simple;
	bh=LJM0Wd7RUEGT+1o4S3J7rTftxoFqM18lTZscyhoCrFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnePzbtzOjhFkKiIGaddUI292TJOeQpo2rID2Coya24GQbCUrm6MfGLcILt7C9AoM6UXQ0fpp8OMfyKPGWquVLF+PCMN1VfV9iw7BrG+CNJFgcg3U+brkhu7FM7J2o7+1qDAyKb+/rWRea6ThP6Lr+6gEx1zjoC6CKlzKdxf3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGlnDKG/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGlnDKG/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-853e2610bb4so39036b3a.0
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787760229; x=1788365029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ql47cxhhPz+pBekLN3rh9Yom4KlDNtrvH/6xbr+Yqz0=;
        b=TGlnDKG/aCWqIj8Cw/g5OFShkYAIArci3YAgKrHI0GlYd8D88s0VEwiI8abN8rkulk
         01R2emyIvPnaZgZ6/H9XbzXaYc3L3sULRT5WwKZeY4vgSJrK/RcokkAZ6O+O+VVFT1gt
         3VLr2FqnwAIsVxUQRAYIzKSXl0qkUF8XeKKP1TtFJLi+okZpqqyOfPcvHE+uBjTBYmcU
         YX1ulnKxriMrQnqe4V3W/gw36xCkzSmsLUbfC75aVSmjb1HRMKgDsx8u1QZmqT7jGZIv
         9ZjYxH1hu8q9sLVHm7mvCIUnqDs+DOlHaMAeS6noJQjuIMU7Q25voXVg5xmTEGlkqndb
         qWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760229; x=1788365029;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ql47cxhhPz+pBekLN3rh9Yom4KlDNtrvH/6xbr+Yqz0=;
        b=VJGdxGTpO3MY1IKWjNt5p7BDj5qa5uQwwkOECb8p8vvw09ixi4HpU1NG04iJvP0L6X
         hD3p6hTob19/ST9odXBWyGIAjWl7POb6TkhJ/9kF5c6fB8QHIge2KI5cxC4+JXLrA51F
         s1DXBSOY4vl6B9dhqNeTPA0yLQgzBRCKNfIGU8DpjAJ+mEMYYh3Ae3ROBs8QlMPWq2ki
         okS7Xv9G2k57GkMnq4DUnud/i0sYUcEW26/mbfTcVMNLlKeZY6BAEsCwsTxhZ7ND7l83
         v7pB1R4OryCX4Y2fb8D3mVspCncnrw2kk71OQabENkXzJGioYrhOqhHrwkzlDezwfa88
         2klg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2yvBGqUv2t+QX6Qzx6WkbO0xGsnJ+wFttEmbUts6cY6nZntdOxjqMYjmccrq+6VtgxD8=@vger.kernel.org
X-Gm-Message-State: AFuF++nYAlqWs5XowBumx8NAIcUN7/kdz4/K2hw+pdNpX+9tezKpj3XZ
	8XYcaZypjQp+DOYMpILOE6MJ6lhmkYFWjhFqlrESJTkmY0Nc5/TThsYZ43dXu4+PA7w=
X-Gm-Gg: AR+sD10YTAgFYNQ/ksaw8DpC19VX5YEqQXErdwx5cVKBegMQUAiGBNOtKLHp8rYyBm8
	H4ZV5lQsIUxsY/y2lTCzZepmbhc39i46LN5//IDhyrOA+fHjHGbPHZ4/nf5gPEOz05dVGpshMaZ
	xkpMFXq7mvS2mE/VZgOYyfx3ypyNOfQSvBrxgZCzBtMeX5G4FNfEnqLPiJ56/FnW7BrvrM3oXZB
	vzeTWCHxCnSHi/eCwwM58uVPJdH2kIRGJyxn9iuLgSP+clBxzuGllSE0llpxhf1RK7Jia3U5Ms8
	dBUBST5ZchvlqNRSEXtuDZIg1J6ay96DTwWXQVPHKNPH2Ujj4Eq0XmMQQZoSKZwmZcHRRTk86LN
	E7p6S2Gnsq30Gq5N9cquB6Jmta5xTQJzWz67zeJMJBVznQU3Lpl1VaXOaVDueeaErsxGGvW89Fk
	yM39GPJVxOYt/vrfvXUtFgGUDLFjdnMRTGMpU8CR+HfLV6BkZoBkhQ03Db2QAJQR+l40w=
X-Received: by 2002:a05:6a20:e347:b0:3cd:9c00:33fb with SMTP id adf61e73a8af0-3d0f4bccb5emr293716637.5.1787760228707;
        Wed, 26 Aug 2026 09:03:48 -0700 (PDT)
Received: from [192.168.55.196] ([218.49.81.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1beb2d4c5sm1104043a12.13.2026.08.26.09.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 09:03:47 -0700 (PDT)
Message-ID: <9e216978-d884-4d56-b39f-d134f78a4999@gmail.com>
Date: Thu, 27 Aug 2026 01:03:45 +0900
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
Content-Language: en-US
From: Sunho Park <shpark061104@gmail.com>
In-Reply-To: <0e74e6799bf042293fd1e34e2f242c56786c3de4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/26 22:13, Zqiang wrote:
> In this SRCU_SIZE_SMALL mode, when queue delayed work timer, the cblist is always no-empty.
> unless invoke start_poll_synchronize_srcu() to begin SRCU garce period,
> otherwise invoke call_srcu() or synchronize_srcu*() will insert callback.
Right, every grace period which armed the delay_work timer is started by 
the real call_srcu(&kvm->srcu, &bus->rcu, __free_bus) in 
kvm_io_bus_register_dev(). I missed one point: the invoke work which 
invoked the barrier callbacks is not queued by the nearest end of grace 
period. It was queued by the timer of a previous end of GP, and it 
started only after the last GP had ended. Meanwhile the srcu_gp_end() 
from the last GP armed another timer even though the work was already 
queued. The timeline is as below:

1. call_srcu(&kvm->srcu, &bus->rcu, __free_bus)
2. One end of GP comes, arms a timer.
3. The timer is fired and an invoke work is queued to rcu_gp_wq. The 
timer is disabled now.
4. Another call_srcu(&kvm->srcu, &bus->rcu, __free_bus)
5. srcu_barrier() is called and queues barrier callbacks, waits for 
srcu_invoke_callbacks() to invoke them.
6. The end of GP from step 4 comes, arms another timer.
7. The invoke work queued in step 3 starts, srcu_invoke_callbacks() is 
called. It starts invoking callbacks without subtracting the cblist len 
field. It will call rcu_segcblist_add_len(&sdp->srcu_cblist, -len) after 
the invoking loop is over.
When I debugged, there were five __free_bus(the real callbacks) and one 
barrier callback, so the cblist len field was 6.
8. Barrier callback is invoked, still the cblist len field is not 
subtracted as srcu_invoke_callbacks()'s invoking loop is not over.
9. srcu_barrier() wakes up by completion and cleanup_srcu_struct() is 
called before the timer armed in step 6 expires.
At this point the cblist is physically empty (head == NULL, all seglen 
are 0) as all six callbacks have already been invoked. Only the cblist 
len field is stale(>0).

Thanks
Sunho Park
