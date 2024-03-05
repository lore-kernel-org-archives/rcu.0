Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED9126F2F
	for <rcu@vger.kernel.org>; Tue,  5 Mar 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650848; cv=none; b=YZBxFVF1ik+CKwfyb7E7XWkT5elZ3igtJctva5IYkjkcxDtUecqbX9huZtSw5iud0O4fdFDYgfyEQv2W4YgcgqdO1B22JtidUlRfLjjsXuqnHLK0iQy6sRcgO4VyYfw7Xt8opSkpfEp9Zf7oMIYrMJdh0Z2a88+o6hHcXu7YAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650848; c=relaxed/simple;
	bh=cQiQOBq98gmRDOXh41IBMCfk0QePUuDe31YKNOmdy84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJz9FBTkZ6yAuRA2zzeS2FfswE69jw9jlVNNjLxo5gjudajyFMo1r51z7AmKEet88Q5E90t5XYv22gsAjm5AXL6hSjL63NzGZgtweXIusbpWWQqMRGNvfJnIPZRSslOhTBNLpcBO19wqoGtox+5A7x9A+V2tuItReWA20GauzoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Rl5VzdaJ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Rl5VzdaJ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6900f479e3cso6864166d6.0
        for <rcu@vger.kernel.org>; Tue, 05 Mar 2024 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709650846; x=1710255646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDHjO4OWGmP09y1KSdxoVSqXaW9/3CmjNrV/1mHKFvw=;
        b=Rl5VzdaJSUf0ZLVFqkgiP9fWYb6p05mQ6VT8AWNpbKT9u3hjpMSqxHGQ+ReO68L1Id
         xS1yNmGnETGV4YyRfJN24Ut2fDWXtbM+d5h9x+SipB55ITAC1vuNDcVGOA6bV/zrITHB
         LGki3jehAcJkJtJ1dLebaguLTgSLBbPI2bwEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709650846; x=1710255646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDHjO4OWGmP09y1KSdxoVSqXaW9/3CmjNrV/1mHKFvw=;
        b=RYw7WH3n2jtxmIfVorROMXboyhSWOR0N9suc4E/FMvOsTrlLGPGBEOIdvYF7lc7SWl
         6jdz3KgQ7LJ/NeE/wmZK2AuZXQTN1DBzhqzjrysluzkJfB1o0TKgkAMgKvyAU0sitPUr
         gItklCJyHFAGgC1z484ZW6cqQrbcG2S1gsRHhm4g82pvWJmTrqx0ov5GId1sC51QWcLX
         pKB4GSJC5Ltxxwp5hDLNVvVCChSBkKVibAuUod5NCZfyLfP2+p+BM+eXsFVHAEKXLQKY
         1SQqPg+5TqGsOOg8612dAqGTjrzwPOPdb8pQgeDSBM4rAp+aqrZG4Rn7hNZKiGRoPn/f
         ZGrw==
X-Gm-Message-State: AOJu0YzO4+DzRFVK9HJ3dXWLBzVKDmtw23WVJl4DXF5YGN1KWtYR0YBc
	MQLSu1A5ZZmp3cn6sm8fVL0fsGx48d+OKHFyR6WScQVpFzpwBL8TtZc/lBUcVIY=
X-Google-Smtp-Source: AGHT+IHsIAGz4pqQhvxc1rwOmasWkd1nfyLaeOLRBa4GvYMAyEpX8Q41rb2m33iOCTWiprtlRiDsyA==
X-Received: by 2002:a0c:cb06:0:b0:68f:359a:896e with SMTP id o6-20020a0ccb06000000b0068f359a896emr2100749qvk.12.1709650845376;
        Tue, 05 Mar 2024 07:00:45 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id qj22-20020a056214321600b0068f73372424sm6321671qvb.90.2024.03.05.07.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 07:00:44 -0800 (PST)
Message-ID: <ab2e611e-3c21-4380-976a-3acee15907c0@joelfernandes.org>
Date: Tue, 5 Mar 2024 10:00:43 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Advice sought on RCU stalls on ARM64 WSL2
Content-Language: en-US
To: Max Boone <contact@maxboone.com>, Boqun Feng <boqun.feng@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
References: <1a5d96d6-2057-44d9-a4b0-8771c46032fb@paulmck-laptop>
 <3718bb-65e38400-d-5cd53080@68830111>
 <99a0fb2c-c936-405f-85bf-847c61531bd5@paulmck-laptop>
 <ZeX327aMIrthOXbs@Boquns-Mac-mini.home>
 <CZLATSBV6XDH.2WUG4D8VJHEQ5@maxboone.com>
 <807b26d4-b55f-4b5e-932e-1252e1ff2446@joelfernandes.org>
 <CZLL3BA2G8O8.1M5NNUFKOJDY6@maxboone.com>
 <CZLW1RFSY649.1B7IZKT83LY3W@maxboone.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <CZLW1RFSY649.1B7IZKT83LY3W@maxboone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/2024 9:32 AM, Max Boone wrote:
> On Tue Mar 5, 2024 at 5:57 AM UTC, Max Boone wrote:
>> On Tue Mar 5, 2024 at 12:32 AM UTC, Joel Fernandes wrote:
>>> Have you tried to reproduce the issue with CONFIG_RSEQ=n and see if it happens?
>>
>> Will build a new kernel today with that flag, and report back.
> 
> With CONFIG_RSEQ=n the stalls happen a lot less often, the system is
> way more workable and when it does freeze up it recovered on its own
> once, and I was able to get the full kernel messages for this:
> 
> ```
> [  675.812339] rcu: INFO: rcu_sched self-detected stall on CPU
> [  675.814587] rcu:     3-....: (14893 ticks this GP) idle=762c/1/0x4000000000000000 softirq=6920/6920 fqs=6610
> [  675.815606] rcu:     (t=15001 jiffies g=50497 q=1304 ncpus=8)
> [  675.816520] CPU: 3 PID: 232 Comm: snapfuse Not tainted 6.7.7-WSL2-STABLE+ #2
> [  675.816550] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  675.816553] pc : __arch_copy_to_user+0x1a0/0x240
> [  675.817689] lr : _copy_to_iter+0xf0/0x560
> [  675.818069] sp : ffff800082ceba80
> [  675.818070] x29: ffff800082cebac0 x28: 0000000001b2c000 x27: 0000000000000005
> [  675.818074] x26: 0000000000000000 x25: ffff00004c491000 x24: 0000000000000000
> [  675.818076] x23: 0000000000001000 x22: 0000040000000000 x21: ffff800082cebd30
> [  675.818079] x20: ffff800082cebd30 x19: 0000000000001000 x18: 0000000000000000
> [  675.818081] x17: 0000000000000000 x16: 0000000000000000 x15: ffff00004c491000
> [  675.818083] x14: 9887db4ae914c054 x13: 6bcd444ce14effe5 x12: 0b22b481c6001041
> [  675.818086] x11: 7513c0250d7df247 x10: b85affa4063b12c7 x9 : 368beb85bc648557
> [  675.818088] x8 : 217c88df9795370e x7 : a16d77942052b4ab x6 : 0000aaf844516fff
> [  675.818090] x5 : 0000aaf844517e2f x4 : 0000000000000000 x3 : 0000000000003daf
> [  675.818092] x2 : 0000000000000dc0 x1 : ffff00004c491210 x0 : 0000aaf844516e2f
> [  675.818096] Call trace:
> [  675.818143]  __arch_copy_to_user+0x1a0/0x240
> [  675.818147]  copy_page_to_iter+0xbc/0x140
> [  675.818150]  filemap_read+0x1b0/0x398

This seems similar to the RSEQ one in the sense that RSEQ tries to poke into
userspace memory as well. May be it is related fault handling? The RSEQ case has
code comments saying faults are possible. But I'm speculating. It might be worth
providing all these details (both RSEQ stack and the copy_to_user one) to the
arm64 folks to see if they know of a hang in such case. Maybe some patch
backports are missing.

> [  675.818427]  generic_file_read_iter+0x48/0x168
> [  675.818429]  ext4_file_read_iter+0x58/0x288
> [  675.818681]  vfs_read+0x1e8/0x280
> [  675.818804]  ksys_pread64+0x90/0xf0
> [  675.818806]  __arm64_sys_pread64+0x24/0x48
> [  675.818807]  invoke_syscall.constprop.0+0x54/0x128
> [  675.818912]  do_el0_svc+0x44/0xf0
> [  675.818914]  el0_svc+0x24/0xb0
> [  675.819041]  el0t_64_sync_handler+0x138/0x148
> [  675.819043]  el0t_64_sync+0x14c/0x150
> [  681.501178] block sda: the capability attribute has been deprecated.
> [  741.700330] rcu: INFO: rcu_sched self-detected stall on CPU
> [  741.701707] rcu:     4-....: (14940 ticks this GP) idle=8074/1/0x4000000000000000 softirq=13021/13037 fqs=6400
> [  741.703152] rcu:     (t=15001 jiffies g=50713 q=5093 ncpus=8)
> [  741.704017] CPU: 4 PID: 194 Comm: systemd-journal Not tainted 6.7.7-WSL2-STABLE+ #2
> [  741.704047] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  741.704050] pc : __arch_copy_to_user+0x190/0x240
> [  741.704424] lr : _copy_to_iter+0xf0/0x560
> [  741.704565] sp : ffff800082cfb870
> [  741.704566] x29: ffff800082cfb8b0 x28: ffff00000fe96b18 x27: 0000000000000085
> [  741.704569] x26: 0000000000000000 x25: ffff0000061e1c00 x24: 0000000000000000
> [  741.704571] x23: 0000000000000085 x22: ffff000117d2a600 x21: ffff800082cfbd90
> [  741.704574] x20: ffff0000061e1c00 x19: 0000000000000085 x18: 0000000000000000
> [  741.704608] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0000061e1c00
> [  741.704610] x14: 62616c6961766120 x13: 7365746164707520 x12: 6f6e207361682070
> [  741.704612] x11: 616e73203a687365 x10: 7266657220746f6e x9 : 6e6163203a313937
> [  741.704614] x8 : 3a6f672e73726570 x7 : 6c656865726f7473 x6 : 0000ab58c96fd6f0
> [  741.704617] x5 : 0000ab58c96fd775 x4 : 0000000000000000 x3 : 0000000000000000
> [  741.704619] x2 : 0000000000000005 x1 : ffff0000061e1c40 x0 : 0000ab58c96fd6f0
> [  741.704621] Call trace:
> [  741.704647]  __arch_copy_to_user+0x190/0x240
> [  741.704651]  simple_copy_to_iter+0x48/0x98
> [  741.704939]  __skb_datagram_iter+0x7c/0x280
> [  741.704941]  skb_copy_datagram_iter+0x48/0xc8

And this is another user of the copy_to_user, so its probably that.

> [ 1559.432083] rcu: rcu_sched kthread starved for 2866 jiffies! g67965 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> [ 1559.433645] rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.

This is an example of what I was saying in the other thread, that RCU kthreads
need to get CPU other RCU stalls can happen.

Thanks.
