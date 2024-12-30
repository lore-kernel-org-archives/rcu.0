Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBD25949E;
	Mon, 30 Dec 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735566445; cv=none; b=Fo58WINtJAMzUw0y3B9Dv6E9fyjzb1z+JhpU7fTVMo+unUeFmIPYdLHhroF4b3/jSL3UERz89SPLlnc+A7p5QOeR+tyko2e/wE2NFunlf9DEdw4PJBF18ap6JjxclILMt7NPOnBFs8AES+BdvFl/JysVa/X9A/W5OY7PDF/GUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735566445; c=relaxed/simple;
	bh=PSSQzVbXkygWlaVn9EVmE4ixfZx1aCgS0BCkL8Qfk6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etLXriBwZxIwJ2CfFEaLNKojhOlltqQJPFekWxMKYpoDfpBebFtCYaH3fFtWgEbMUYCfCLDLwsgJuEw0Lx0drlgDcvZKfSmcoP/3A0//DGOUXKkcoIN33dn+fIvbodN3y4+mItNNdWm/wPxlZjVS7Wm/erIWL13bFwlp35pYZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbITfOSF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbITfOSF"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43618283d48so66944825e9.1;
        Mon, 30 Dec 2024 05:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735566442; x=1736171242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIoaeQcycDKHol9Kt39rKQhlD5BXaiEvoLOIeg5Dolk=;
        b=YbITfOSFfrxLYutPeifytFO8q2MQTrmySy8R9coMqzCpaSA01oPwEymQD3m2Q1SwTn
         V4Vz6izUFn0VLsEpXW66R2QXLOfPilGq6ajQOubb8xtTNmZ547bnfhXNEaI94E7gHAD/
         ByD8de4b2Wn6s/xCPQ2SmjresfjpZxLbTqh6o6So9JUXi6cOZir+VlA46uV980oatwD8
         8U+oynu4X1djV5aUjnbLxgDyK68XFeCijFybhclqHNlwzc1Ek7I4S1+TQl+OxetzYGPt
         nE4o685MqeZzyB45VYKskUI3niEUqrlIBqSI32OJhVOlPjXkulkk4o00T1MAnivonYcR
         LkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735566442; x=1736171242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIoaeQcycDKHol9Kt39rKQhlD5BXaiEvoLOIeg5Dolk=;
        b=k+4vDxgN3f2NNCT0jbN1W6bv/nL+YHXTEtzCm+DnsgxxR1b+edueY6avoppNVv7WDV
         INtC3uRYqgRHcypwkhrqeiLcsu9LG21cUIGu8waocTxNNJPlioflqoa2BmZ1YnTpuPuT
         kc8PWgL8WEYp8ouC6ZvTs7m5Ew+U0FGjEQ+2bA3sXz+Z8WLCSwaEeukCgHmOKZdYevxv
         bnpMbuE6CUl4lpLbUeItzuWWp+izMcOvuuhA8Nu31fMjHORG2B35c+yMIbSC63ZM/3al
         g/7APh5SOvlrmZbgggzTtefO1UAGwuWzlu9AD2nv1uEineVG9IJ2XaDx7zwEgEJH13CI
         OYaA==
X-Forwarded-Encrypted: i=1; AJvYcCVtzET8cplYWgIXHorCsyP3W7hHgd2v/uhcwem2c0Sob6VZ9GwprVTHbhhphC8e+YXv3sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3lwt3Z1GWN05ZoY+Y0ghxpmiwLKRLR60Y5w9WXZf5Splrecx
	ceiAd5VuAbckxh1DMZ9bR8mboomjzjEdx9ll7asA2FiGHFUQn47l
X-Gm-Gg: ASbGncvQMrEaU81oiqBGJijWi6v33Svf27GUyuXQNdcAOCMJnbNqAjhJpZQAnvUPDyD
	j1rGE5ftHjecDo3GHgqiu0y+zQyNBt6fam2XMAkNG65w3tCtruGTgw/rMiEBIQcOTPPqinTV57H
	/8aVn/jpxGzSJbPnMyordpetms40RKIzsI5ZNOfk1Xu3f8cgRwkQzfgJgwvFfWyps6iJ099gLmI
	fqhMDUaYV1ehAoqamD3eWdEq293T+jJK5Su/3IvVwjpBVw8WgGL3dAYFQloG26N1zRBZUoLfZbM
	yw7d8qaZToQUrlSEzUJYZquWETtAqmwAoJkFOa8nvjvrIRNO1A==
X-Google-Smtp-Source: AGHT+IENWd2WybwE/qugh1YxSN6Ew03rU+78iP/JCNgRXl7GShJUuCWKkxvzSJJyQDbnKz9sapfE7g==
X-Received: by 2002:a05:600c:19c6:b0:434:f2bf:1708 with SMTP id 5b1f17b1804b1-4366854740fmr258573055e9.7.1735566442093;
        Mon, 30 Dec 2024 05:47:22 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4fcsm361150545e9.29.2024.12.30.05.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 05:47:21 -0800 (PST)
Message-ID: <ee6034d8-de87-4f37-be49-5e9e71b704a5@gmail.com>
Date: Mon, 30 Dec 2024 13:47:21 +0000
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 v2] Revert "rcu/nocb: Fix rcuog wake-up from offline
 softirq"
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
 rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 Cheng-Jui.Wang@mediatek.com, leitao@debian.org, kernel-team@meta.com,
 paulmck@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241226233052.145450-1-frederic@kernel.org>
 <20241226233052.145450-4-frederic@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241226233052.145450-4-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/12/2024 23:30, Frederic Weisbecker wrote:
> This reverts commit f7345ccc62a4b880cf76458db5f320725f28e400.
> 
> swake_up_one_online() has been removed because hrtimers can now assign
> a proper online target to hrtimers queued from offline CPUs. Therefore
> remove the related hackery.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Usama Arif <usamaarif642@gmail.com>
