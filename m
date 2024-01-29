Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD122C6AA
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561333; cv=none; b=KtMjgmrS7VG51kQqaR8gH68om0eYDd2FT7ot36l6Qa7hm+BEMi16Ywqd/Cu5hN5c+m3K7/sJr/j1/M4aqa18V6ETfVxi3UjOtWKujk/+eyxyzTsPKt3/P3t0G6Rifdhyw1//5nqwoDF5p4KQxLqTw+HdmLjAIwcZEZ1NFCTTFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561333; c=relaxed/simple;
	bh=1mV+SfsUyHF3sX7hYz2FcIsvuFHKTDAU6p1E2hrgEds=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCEf3V+9v3BE9AQh7gtMuAmHvodMm6cWDWcPTugwmxh7xJVoO2FQ1xrDorTRmWf1mln1MbsVa7opFNxAJ/T8NAheAbLJXDywW2cLsfq6f0UGGzJIMqiOdVUWfnQXjQMOBjtV5oYvDrX4Y0Rn4auwW7/K+rPw8Au1avkm1FQrKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsNX1aqq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsNX1aqq"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51028acdcf0so3830178e87.0
        for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706561329; x=1707166129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiCs1ycIJl0x5tWCiIoe3nfx+ecakXxr4KjmkO+WO+Y=;
        b=NsNX1aqqvRX96PFUOJ+3f7mdNtAj8g1eWkKqZBBnHwhcuk+6/UURdif8VyCUuaVTdV
         SqVVLtWbv8H3wyC3Ssz2iBwXRPzvTP7/eEzi2GkN4dd36gPv79rwaYb3sWqfiwYto/HB
         b+GqXCHq5L+T+/8XXybEj+2lD86egBmFezOKc8M5g6nF0Dsrm5dyzTWyUNZsHgmz2Y2d
         5j3Y3cScBsnH5CUvCyGQbxHHaQz0rgzlSe4hQKcVOZ4eVm53cc8v+gsZ3uJtbvgG+1hU
         dxkvVQq9xb2v4zvNA5TP5QygTk2BkvQDP4ifXLDG3tIAl7uZQokeXEnUW+KJMUpNjix3
         hQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706561329; x=1707166129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiCs1ycIJl0x5tWCiIoe3nfx+ecakXxr4KjmkO+WO+Y=;
        b=T0furLtI1fCoU+OoYGxcX0nOnlB7c0u/MjwUG/AWqWJSnqEJxM/ayZUcZ453rQKSEx
         E54JljhC9EpPoXcjGkQQbfMtfSROGLwGPo3KBg0M6BYeMvnRK9+sHzW7PpR37edRt8Rt
         +8vBW6kmUB3cqWBUwhZsIHKgmz7f/jVHhIRnr2DdrQs/rqLnaCwFLjOMd09qIsRRJGY/
         0UjSdiT9dXUD3WUeZ0mg/s7l10euW4VYLnkeSQ1rkTuCKUTPw3QKkwwaUzobxpDBHIYL
         f8zvrBY1NWbVS8GB68917OLTYYH0vSKDwh2pzcYgg3QXQkxJb0Mk2+rFqhX3M210I2Ct
         Rfbw==
X-Gm-Message-State: AOJu0Yy0LlZnef9A9MzG99NpK57EA8N5t8pNE/wB4p5XL3HcZSf7+EKm
	VfYbhlw9oCESn2vKGcwmnOXhvDRXm11JghpseXVLc9N5TIhKFwLxPy175UVq
X-Google-Smtp-Source: AGHT+IEsoDTRhU3O+FOCBNrJei54/NTjNpwQezDTS4XtXvpVNNkYskW3gcXibu2m8OPvMP2HuxuN0Q==
X-Received: by 2002:a05:6512:ea6:b0:511:863:4a0b with SMTP id bi38-20020a0565120ea600b0051108634a0bmr4043621lfb.60.1706561329119;
        Mon, 29 Jan 2024 12:48:49 -0800 (PST)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t1-20020ac24c01000000b0050e94329e7csm1218785lfq.269.2024.01.29.12.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:48:48 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 29 Jan 2024 21:48:47 +0100
To: Joel Fernandes <joelaf@google.com>
Cc: rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZbgPL0Rg_on4kOBf@pc636>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>

On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
> Hi Guys,
> Something caught my eye in [1] which a colleague pointed me to
>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
> 
> The test in concern is:
> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
> 
> which is a CPU intensive test.
> 
> Any thoughts on what else can attribute a 30% performance increase
> versus non-nohz_full ? (Confession: No idea if the baseline is
> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
> nohz_full on some of our limited-CPU devices :)
> 
Timer overhead and its scheduler-callback? If i do not mess something
the NO_HZ_FULL will disable the timer if there is only one task on CPU
so that running task benefits from not being interrupted thus gets more
CPU time.

--
Uladzislau Rezki
