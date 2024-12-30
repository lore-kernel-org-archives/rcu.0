Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1159525949E;
	Mon, 30 Dec 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735566369; cv=none; b=LWJ4WmnVKxCxPkB1L5DrOWfR0En+lfVmy/UpiiHRnSjlpOEAcq+5LbZA/1eqQpy55TC9mnsrBWvWWWNN8msE1wnO4/iPvJ1ySkDAaC5YNJXz8PEt2fqr+RCyYd1A6NsYC/HNHHbm95ZMwVfl3ZO7sELU0sE/gwmlV+rH7eJlnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735566369; c=relaxed/simple;
	bh=SkDU4Bc0PeaLOZ74OgNuwx45141e0yrCXm4eo1SlvAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+zlR9da9ogjuq6gzvMrCMQj59AWbaBc0Ppt5RQ5Z4uahHwPECyvxcaMCJruybQgn+0m/IiuRwAafFgaHQLoroQYKqRbs8zLM7DP3ncTJr5tTXQxKMX6wifPBvmRhaFmEB2kQTtM5DQl+x9ki8/YQFUxjrPl4bCZdVGsWF/cFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtfyJ15w; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtfyJ15w"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so4752666f8f.1;
        Mon, 30 Dec 2024 05:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735566366; x=1736171166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPEOXagxz7HKGm9maKytIFXlLdX4/HAvsw4YATuvlXM=;
        b=OtfyJ15wxnWOAQHhv+v3nulpQwI5PjnEnz4Dbzi3XxPtT7SLY9DI3+Klsdgn22x7r7
         x+P8EkYT1RToqSNHV0CufgyFGIQOwTe4RtGH091dUED12214Kq+d3dh7wyCVNp2Y7V+O
         wFQmXPIjA8JPVNGjqmywO1WID9eamA2CeCLzc3w3v37E+zO3ZcNulb3g9XTYWvu4S1Tv
         cJCII8mUIA62Dsps3ljB2V2LNL8QYC42pxpIwG3wfrZwJ2ToZiYzPvJ6d8t1E6kBeeuw
         Cl0bveOakEtzHRF286d7UCWtcU/v8LS7B0+38XvpA5m+Ik+l0A0Kp+Ih566vd0S2Ws5v
         i3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735566366; x=1736171166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPEOXagxz7HKGm9maKytIFXlLdX4/HAvsw4YATuvlXM=;
        b=A9Vzk/a0fYaxead0XsBvSqY0Ise50X74tDAvlSRyrO4f3orGHH1vs6wspsxakknrqu
         mWFKwQ5W9uWrQKdIrHVipNMAkSeMd6OGFRFS89NSzq8Rhm/eC1j6z2X9oSuxFaZcqC6E
         x2moBDBFPWiNYW7Zy3KPeLfCGBUCPdLT465ZnjqMqetu+aWZ3RuYZNIgyE+znclYB2Nv
         L1m31mTV4SpTjB28x4kJ6gFqjGuRYTJ6gwiNnPFXvvZlc08X91eyn4kO097zi6bC594G
         tLXGCWwiau1dNAKVEZhaYHpYz6zhYF9SNFyLFDblECvsXgjSjBIl/uDABRSs2vhLx2TO
         7FGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVBjDWDDiDBvhCVrevDgSSThupTpMZ+sTuZJD/mQvZmdoNjFcK9yvkbhxtRyBzm3vk3pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmRNVKckqBdf8mWjd6hob+uyNzKULpGeIPCCL6+xtDMR5uviuJ
	1MnTKS3HSuwMHEXdj+bDvVvWqNyNstEY/9/5K0crn9UCWVwqU3eY
X-Gm-Gg: ASbGnctp03i7VuczwwXdPQTrTdOFBmyMQiaKmhQmCrKGSS0ffLM434BmYxI8nefhLgj
	ExGGT9v6T+0kQzEJ4McI5K2bk3cTPQx/NCe+m3FLaKHZWlr7aCj40K8FVTl01zX5SSXC5NBebOp
	/fVpFvPdZY2qgn9vued/5YEDf4MaPjeWRMRxomJgl8Fbk1jrFLdUUqGOr5UMxDKykx1ahH1E3YW
	RxjyhuJM3w9ZBoE/VOeygHtfWfGWzY7OL8fTJ1YfoQ2ZCe/h7vHCrPN1Smnqfvn0G/Q9OYprCqu
	sNq0EIyUt9KGceBn9sLnPPZulekselCnYzJJdBZ3BZPpPhtdKg==
X-Google-Smtp-Source: AGHT+IF8vsq9Ixg4ac4zy/u9cvqNfbyAKVZXLZxOozvJ2pdHaoAM0slH/uMzSt/efO3EACXU7SR9Wg==
X-Received: by 2002:a05:6000:154f:b0:385:ef2f:92ad with SMTP id ffacd0b85a97d-38a221e181cmr32736336f8f.10.1735566366187;
        Mon, 30 Dec 2024 05:46:06 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c493sm353202875e9.28.2024.12.30.05.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 05:46:05 -0800 (PST)
Message-ID: <c906fb34-7b63-4829-bf2d-1ee0ae85d4e2@gmail.com>
Date: Mon, 30 Dec 2024 13:46:05 +0000
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 v2] rcu: Remove swake_up_one_online() bandaid
To: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
 rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 Cheng-Jui.Wang@mediatek.com, leitao@debian.org, kernel-team@meta.com,
 paulmck@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <20241226233052.145450-1-frederic@kernel.org>
 <20241226233052.145450-3-frederic@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241226233052.145450-3-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/12/2024 23:30, Frederic Weisbecker wrote:
> It's now ok to perform a wake-up from an offline CPU because the
> resulting armed scheduler bandwidth hrtimers are now correctly targeted
> by hrtimer infrastructure.
> 
> Remove the obsolete hackerry.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Usama Arif <usamaarif642@gmail.com>

