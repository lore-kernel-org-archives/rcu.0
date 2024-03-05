Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780B86ACB
	for <rcu@vger.kernel.org>; Tue,  5 Mar 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650206; cv=none; b=ESFshoTifdWLuH24iqsOdQnS/BS8TsvFncrJnTYSbxEbhvvcDi9i59KE+VAQmc86e09S/uyMqQjFxu/8nFmdtw6RAUK2oOdyt1jJpUSWRReh1DDirD5IMtZX+qkooSa2tuXP3eXCFFoXXRxIaQikQLjTiD1a+62Du0oRx/FAfxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650206; c=relaxed/simple;
	bh=D+4ZmLPtI2hx2PxqqiPUMmPuId3LWjbXFMy44T/HOuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNgycuo5fTmK9U5gB0wjf/5u8HICE5TV8SUspTuIUdSeIWkyqATtyEx+8lNv496SMT39zYEj9OrFhFo1+ywwbTG3OZgyefw0VT87LZVPqlVrdQ5v8D0ReCui5ZvW7rLGUTTXvxdohbkQRQtB7Vn9mWK5molGFKDXTt0lxBy0Ji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=SakHzrWj; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SakHzrWj"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1af1e8b7eso3099646b6e.2
        for <rcu@vger.kernel.org>; Tue, 05 Mar 2024 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709650204; x=1710255004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q73ExzgHsdXypnGepCKVUDIWbBO1rwaKTAOhno+Xpn0=;
        b=SakHzrWjGRZe4dp/dO/lekzSHvYZzk0v6Vv097a7Y8gC8e+lJ5IDwIDb5poHTiVHvJ
         TU7gImZIcGJNyjk1Q/jEzS0khd1BgFDyqTFcf98R1MPbMNKWsIaZGsiHiBcm3nGl1Iw3
         mFUls1kQZjzDx6flQZD4uNMoeBJV9NlceVsE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709650204; x=1710255004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q73ExzgHsdXypnGepCKVUDIWbBO1rwaKTAOhno+Xpn0=;
        b=NyEf7ZZpnID8hhrU0LvF1tgHBJdGHJCJDj2KjfwQDHTcTSPsWv6b7dzOL8Zi2eMEZ2
         MsZ1RwrvuBHN6+rCCX1MpR30ESW+6fQ9Xu0EwXxGFIEsqFaqJuLo+Rew/XLLffnIIDOv
         9qoaIGP2VDjnZwGQj/KEzWAO5BsY9MjdcEvgqh1TFRwdwDdSJyriYSatbonJEp1w3weW
         3BVw2BpqPE3Rd8r7tZGlb2/QjKipASr6DpFL2laIIcEvUESPREclb1XaK+vGiq1+3Kds
         0YnBLR4J4grEAJ7ZzXPQU5V33suO2c3hZuqe6DVeQgiAb31LoEv06CD0SwNEwzSctMVJ
         2Naw==
X-Gm-Message-State: AOJu0YzU2ZrhTUMXW2hymGmuF6DHbOBWWWNSEXX4A1Ayd22NGvGo7pqz
	xLzmKllN7f783zEi1zDfP5hWx38CEQxIsVL8PilTdmp88lzK6PN2as19T5SB1H4=
X-Google-Smtp-Source: AGHT+IGg1FhbqSwtLxnf+WyxVGdTVmx+2tH048uXNyi7p+XZ0TRfBoJzFKcxUn5WAoNu0Yq4fP+rFA==
X-Received: by 2002:a05:6808:2819:b0:3c1:c1a3:39cd with SMTP id et25-20020a056808281900b003c1c1a339cdmr1977272oib.25.1709650203889;
        Tue, 05 Mar 2024 06:50:03 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id pe23-20020a056214495700b00690766cd5b5sm2191365qvb.141.2024.03.05.06.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 06:50:03 -0800 (PST)
Message-ID: <f308870f-2df8-4eb1-848f-ba9fcd08a241@joelfernandes.org>
Date: Tue, 5 Mar 2024 09:50:01 -0500
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
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <CZLL3BA2G8O8.1M5NNUFKOJDY6@maxboone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/2024 12:57 AM, Max Boone wrote:
> On Tue Mar 5, 2024 at 12:32 AM UTC, Joel Fernandes wrote:
>> FWIW, I use a Windows machine that has WSL2 (kernel version
>> 5.15.133.1-microsoft-standard-WSL2) and I have never experienced any kind of
>> hang. Though, this is a desktop and not a laptop or battery powered device.
> 
> Is that also an ARM64 machine, because I have never seen this happen on
> a x86_64 machine, there it runs like a charm. Out of curiousity, if you are 
> running an ARM64 Desktop. If I may as, which one, as the Volterra Development 
> Kit is not available in the Netherlands.

It is x86 for me.

>> Also this github thread looks awfully similar to the github thread you pointed
>> and has the same clear_rseq signature leading to the RCU stall. Over there also
>> it is a hang, but they say the CPU usage is at 100%:
>> https://github.com/microsoft/WSL/issues/8529
> 
> Indeed, when the RCU stalls occur, the CPU of the core that is stalling
> ramps up to 100%. I had thought that was an effect of the stall, but
> will check if the 100% usage is caused by the process that is stalling.

Right. And, RCU needs CPU available for its smooth operation (for RCU kthreads,
interrupt handling, softirq etc.). So a CPU pegged at 100% for long period of
time is not ideal and in your case likely causes the stall.

 - Joel

