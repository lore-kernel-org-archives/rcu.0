Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B067F
	for <rcu@vger.kernel.org>; Tue,  5 Mar 2024 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598766; cv=none; b=kzEYdTAipYTsNmUYKckVo37yFbgHpUSdCR4FGx/1teG3oyRGN3F7PeGLF5yvrvlYLLba3TEdn/hMDJ4Z7GyK/qd33qMws8hekWLjvUVnOvovblJNyx32jRBdhaYgMhM/rdinQK6YTi6QbxHa+dVR0uIEIM+okQxIe4rXeGiPGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598766; c=relaxed/simple;
	bh=iWQl/6RQlN/zNqNR4kTe34xlxLIIxMOryco6xvNVonw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdUzZ5y4lkRw6edqFxdM87aPfJ77jHY51mk+VXcEUfyXxEZSMfpqENdjFIjBxtooKx0mVa0WgMYBMZJPE/oqCd9AtzqZ64kAtO6Tsyjo7SgPzTW7moy4t39qPH+Pkn5+IW2hoAbjYDTX4Tme84QrYKHcJTlaDO18qfMWGJh4LEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=bdSZkDNw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bdSZkDNw"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7881f80b2aeso9417685a.3
        for <rcu@vger.kernel.org>; Mon, 04 Mar 2024 16:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709598764; x=1710203564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WV8mDq6l2EjOaxCqWEUSzY7tUhb+K+Ac8/LtbnQOkOM=;
        b=bdSZkDNwSx5a25My2wp18bcyWo+FQn4+77jufjKx5R0XQr5A4JV8P2mlNPoTwOmyKx
         CU7zmFO2+I59VWRy9WHvK1KubyNqIwqYwbi2LkoK8mxFIOnKTy989RQEdg2x7kCQ7r7D
         kCC34Cy+0BGZzUr/1NNlkalTlSPkNAIMuHpUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709598764; x=1710203564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WV8mDq6l2EjOaxCqWEUSzY7tUhb+K+Ac8/LtbnQOkOM=;
        b=BlmYqPhasNfW+1ZfiRDsbMf5HTVizKbEBL9h11sioC5OTlhKLXu1VqmMa1ER+rqzwA
         oN9wdhZTvj6uXqzLx+d+qOD7dtmvCmoKuZTAsoV5mn1ze3KoD+kmXbXeU2O8mR98e/6F
         jtgILS110EzqzLnKSIGWJCHo+C4GJRgcAEvDiej1d4cGQhOEWppBi8jzaJq9QmytKDre
         ABRKQDBb02k3YenuHmutw0jBZXS/vT2sMYh/UFV4+yTG6dcZa7EiaKSSit35Wt75PjdE
         naS+iAT7uAL12O0PLzeKKa1jutvei7YkjlEj33C1n2y8vtJqpjIjxIBup+05NYFvSpGh
         vOgg==
X-Gm-Message-State: AOJu0YwiyPG4RD9tnf+8Q0BtvIg22Ms+9nH58V0uzHUGWyG7kJH4GYRS
	xe5W4vdU1LxaBLjdkBYXnGeLYVNaEJYXVbNzm3LD3bojRbOEzlWfIFLdJNOut64=
X-Google-Smtp-Source: AGHT+IHPAALYhM466hEW1D4/t4ZqJoh6RdS0GjgKYesnzrBtvfWfIRddjPjLRouZpJksRtZkDtNeHg==
X-Received: by 2002:ae9:e31a:0:b0:788:254b:de89 with SMTP id v26-20020ae9e31a000000b00788254bde89mr399443qkf.17.1709598763636;
        Mon, 04 Mar 2024 16:32:43 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id q15-20020a05620a038f00b007883218feb7sm483248qkm.97.2024.03.04.16.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 16:32:42 -0800 (PST)
Message-ID: <807b26d4-b55f-4b5e-932e-1252e1ff2446@joelfernandes.org>
Date: Mon, 4 Mar 2024 19:32:39 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Advice sought on RCU stalls on ARM64 WSL2
To: Max Boone <contact@maxboone.com>, Boqun Feng <boqun.feng@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
References: <1a5d96d6-2057-44d9-a4b0-8771c46032fb@paulmck-laptop>
 <3718bb-65e38400-d-5cd53080@68830111>
 <99a0fb2c-c936-405f-85bf-847c61531bd5@paulmck-laptop>
 <ZeX327aMIrthOXbs@Boquns-Mac-mini.home>
 <CZLATSBV6XDH.2WUG4D8VJHEQ5@maxboone.com>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <CZLATSBV6XDH.2WUG4D8VJHEQ5@maxboone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello, Max, Boqun and Paul,

On 3/4/2024 4:54 PM, Max Boone wrote:
> On Mon Mar 4, 2024 at 4:33 PM UTC, Boqun Feng wrote:
>> I haven't seen this issue before, looks to me the stall is caused by
>> clear_rseq_cs(), which is basically a put_user(), and I don't have an
>> immediate theory, could you share the kernel repo and configuration you
>> used, so that I can see if I can reproduce this? (Note I don't have the
>> exact device as you do nor an ARM64 Windows system with the exact
>> Windows build you are using).
> 
> This happens on the default Windows System for Linux 2 setup, thus the
> kernel built with the following sources:
> - https://github.com/microsoft/WSL2-Linux-Kernel/tree/linux-msft-wsl-5.15.y

FWIW, I use a Windows machine that has WSL2 (kernel version
5.15.133.1-microsoft-standard-WSL2) and I have never experienced any kind of
hang. Though, this is a desktop and not a laptop or battery powered device.
> 
> It also happens when I build the kernel myself from a more recent
> release:
> - https://github.com/maxboone/SQ2-Linux-Kernel-Builds
> 
> Microsoft should have a Development Kit (Volterra) with identical hardware 
> to mine (and other Surface Pro X, Surface Pro 9 users) that run into the 
> same issue with WSL2.

Right, so at least that's a data point, that its Surface-specific (?). Have you
tried to disable power management and see if it occurs? Like disable suspend,
disable cpuidle, etc.

Have you tried to reproduce the issue with CONFIG_RSEQ=n and see if it happens?

Also this github thread looks awfully similar to the github thread you pointed
and has the same clear_rseq signature leading to the RCU stall. Over there also
it is a hang, but they say the CPU usage is at 100%:
https://github.com/microsoft/WSL/issues/8529

thanks,

 - Joel

