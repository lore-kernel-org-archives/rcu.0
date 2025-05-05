Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA338C431
	for <rcu@vger.kernel.org>; Mon,  5 May 2025 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486095; cv=none; b=Mzvbsme+5V/yDN6SdMneRWJOtodC2Nx9+298RX/Hie1AVDpq6qI3THB8hfo+nP0BjDVjh8+czs95hfbii8Ar+ah1RfR3RG7pURKccLi3SCzMH7X1v1PPrLzNLGAW3Lm31IauUQS40KcwHxQEyrVerp59PGtHF4DljKFMn0eECdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486095; c=relaxed/simple;
	bh=QwsMXzldbrU8SzdqU5zACd2JeDzRrZxTT5AaXo+baoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nS6u5E/W3yii1RunEYkejgZTlwUuz3VrTDehz/Vejmfr7/e7tvVpfAwhray17jSSz+e73BHH8BakjCBpM3uSLfSGcLckXsvrgNvf8KhNx+tpaUem9XpNf6OKOEpxg0tnkT/CxObRROe/4W5Vk/tB3nbp0uZNVnynRao6MgLhxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22de5af5e14so6342925ad.1
        for <rcu@vger.kernel.org>; Mon, 05 May 2025 16:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746486093; x=1747090893;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsSmKJ5UHHQsEUgRQcXm7hdKLP7W+pGtFiMZ6v+hmYM=;
        b=FCBL1PWxxl3OqrALXOlCFv/PYIXDuGWDz8IBz4zyvRaXtXrfNPZe1ZwI0Zp3PMyANW
         sMIQ9W+rkUnYxU/BJyK+rgnJw8q4oRoImST45h36zyM7aXCxvCjkGR6Ntk4AEGRF9aDZ
         Tm3ZmaD3Ah7obrw4zQXZNfyFuPZwkrGx5kLq5xB24FbKbPiLwqWrguqFBqB7ooQgpmg+
         e+bOGsmZy+gXK2+Jf3GoaMnEoBDWsluYVJPz8ortNz8i7wPjBkVcSTBi6UUmQ7Cac2Fc
         qYqzXMJbyREBedUGkkHSIFRWbXKz/lNtWpK+FkUstMIIPemoZS7HrpQV9vtaEX+DJrN7
         RkEw==
X-Forwarded-Encrypted: i=1; AJvYcCUrzVKiWkYxx0LzHvSz7/Trr3kw5s7FTXPRml9cRhR6pOFjdwwKoQWEYsAXZzKJDMlPEJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9B7MqXOSJTMUuFS45IuH2UwvnJXiYj3c0k0uwv9YIaSEEzFuo
	RGSk8KKhOQtnOjbZTe+QHx7Fd5VSUFm6lNQd3v9v3hTloDHDtlGb
X-Gm-Gg: ASbGnctu+ZHuhULOrtAd9/PNTQ95vN5nJH+xWg+cM+Jf+MuEc/St+IKiyshXIKxZWkW
	qWTZV05DFy28GW7aDwjJf/lo4g96JSh63oRazF5aBjH47qGEuQS14k/A5ZrTTwxIxHF0BMvvAb3
	FywpaSGMMbwFBgrdsNXr4hP2E7vltvTyPQCm7DGpnsVYnAqN2Ee6F1K5rVqq1CnopxApssJeC49
	+JAhNKzY2+io0Vn7h207paERfO+q2FTw95doL5xtz69GHJq++4+ZoVNzblvC00hC/5j3VObVh+a
	T8ED5k3dYxzZvvuiBdhY7d/jfBq/4c2f+DM7TOLbi8CSMLTEgyua
X-Google-Smtp-Source: AGHT+IFKX+MSWFcXA+xF1cWqc/F7Xi76KOxa4y7oRIX6kd+7RGM8qTzemDmxhtEPSEuj9iI9wy1TEw==
X-Received: by 2002:a17:903:2d0:b0:22d:e53d:efb7 with SMTP id d9443c01a7336-22e1031e35bmr79874405ad.4.1746486093119;
        Mon, 05 May 2025 16:01:33 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151ea213sm61139755ad.94.2025.05.05.16.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 16:01:32 -0700 (PDT)
Message-ID: <ff63a928-b78e-4ec7-85cb-b4d45c34246f@kzalloc.com>
Date: Tue, 6 May 2025 08:01:28 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] RCU: Kernel panic on execute from non-executable memory
 (binderfs + stress-ng)
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Colin Ian King
 <colin.i.king@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 byungchul@sk.com, max.byungchul.park@gmail.com, rcu@vger.kernel.org
References: <8bdfa4fc-0e4a-4965-bc29-6ab6c1573ef6@kzalloc.com>
 <048c2c88-ee09-4c81-96bc-255813202751@paulmck-laptop>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <048c2c88-ee09-4c81-96bc-255813202751@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paul,

Thanks a lot for the confirmation!

On 5/6/25 7:38 오전, Paul E. McKenney wrote:
>> Hi all,
>>
>> I encountered a kernel panic in the RCU core subsystem while running a stress-ng on a virtualized ARM64 system.
>>
>> This panic consistently occurs regardless of whether I increase or decrease the memory size.
>>
>> The crash seems to originate from rcu_do_batch(), jumping to a pointer (0xffff00003a114000) that appears to be non-executable.
>> The PTE for the address confirms XN=1. Given the heavy binderfs workload, I suspect there may be a use-after-free or dangling pointer involved in a callback invocation.
> The CONFIG_DEBUG_OBJECTS_RCU_HEAD=y Kconfig option can be helpful in
> tracking this sort of thing down.  KASAN is another option.
> 
> OK, I see below that you already saw these, so I guess that I am at
> least providing confirmation.  😉
> 
> 							Thanx, Paul

I'll continue analyzing this issue and take the opportunity to study the RCU internals in more depth as I go.

Best regards,
Yunseong Kim
