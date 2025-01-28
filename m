Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414F1A841A;
	Tue, 28 Jan 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097725; cv=none; b=Rkpx4enW54uO7QaqgOnFawq7rr8r8rbbIXkfBpz7+zcGKKZw+u7wbfHAIgz46/HgOigB4QD0RCXOO681NCT1HtEL7KGiOXewhHi89mbYJ9GdKmz9M+wde2mXwoHRtmYDIrPf9uXa230tJRf8W+o+Adoqc5cNkL8orCXaCcdCMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097725; c=relaxed/simple;
	bh=4rYKlrPWnQIta5h4pEA7hiqXT/yGBPBV6JTNREa/fN0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKUgsbO4HIl+5DcEQRwJawzwuLyjcoUOIQsvhoXmUIUOnYHJ7CnyHecWeigFrpWKlmJB6dqkaX4kIDXXHxNlqvEF/QcKSjd58Xp7lJ0h20ix2JfAij5XJ8XUr+/oRzr5mtiP5v5swLNTDGkOy8Q2rIepphyS9ewD6dvLYimaoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpfe0o+r; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpfe0o+r"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e3c47434eso6521004e87.3;
        Tue, 28 Jan 2025 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738097722; x=1738702522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N50IokPivy8oxxUTlkQa93N3DuylXE7gXOxIP2Lm/LM=;
        b=Mpfe0o+rcFL85thIr9278571AWcGzVvend+R6rbQImFBMRywmUYlC676yNt4AQWeQT
         sbz9e4c/fvdh5XZIoV9icjVFArjeGCMocdHbQ7rAECCUlzPqKCJowmReDt4uRrJW1MLC
         pmjgH2G9T17NitYW7eMUVIqwf9uClBOvWvS3GH+Ocvo306ZrfvhQfcH50tbNpB5GeG8T
         6fwK/vz7CdbRf3zmNs5v0NtClzMUvT5KWqPPAE6wiVVLZ1AO616+7nenTBB8sERVO7PP
         Bfbvt/E/l6hwIGyHfUrntxavuQbqw8IU5N3noiGMCvbJI1Um+85Hljb7ypeZw7Z747Ke
         0Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738097722; x=1738702522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N50IokPivy8oxxUTlkQa93N3DuylXE7gXOxIP2Lm/LM=;
        b=v1RYaNMqHdkQfKwHxABYZlo8+ZOBLGAx0gBNZz1afEUrZQqdt3Xut2aDl7fFaGZ4gx
         g0Cxz8YWfJDk82kZS0d8XSGFo7Lpjfo8AzcaXfV9CjUCYA9o/k977F8SvR1SN29n2LRI
         BdYuX2Zxo+zQUctaGyvSj3gr65a464CNbBmCTeqO/QhzGVcmQ89+HlCR3YkVMIOrisSi
         qgiJRcY2lb3UY+QoiIbJ1V8GCiuKB8xNWxea6X4IPNEJhlrNkRRu8FvkvcLAyG1b/1YK
         a05/ybs5fQ3gKRhzO4PAYPeLbFIb18rFKJJMAhZduPKByx9pl2Re5fJXnMJ88cYhhQPP
         bfow==
X-Forwarded-Encrypted: i=1; AJvYcCUNPlLS9hj6kvteskiSSnArJuAt8gewOIGRgXfm74ud7+mAJvvsvNZLlA/kvaXzo0hXgmVosdRELhAZBEc=@vger.kernel.org, AJvYcCXFWGnYrGsVOgwIJRWOGgOTlN5rmHAzeJJtHZnSpumpRSR48pd1d+zTnDX5fo0EYOP/q/Qp@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHSuPRb7v9mUlZBdh4l8VFKicSwF/xMGFmSKicB33Y/8FUAFQ
	i3uPJiRMuOOinkcVZMWtOdnqRX6nnOP54XxAgl4cADbpjMeRTDWF
X-Gm-Gg: ASbGncsxWV/P/sMnL6nlaKbIhff5MQcxGIf3H1gF1K6dOBqJnJEysCfKW4q40jl0BPT
	9y5+Tb2XmJs//gO1To6WMh21TMernYY017eH/KuNa0CNlE4LVtht7nVZbGhqK0v2Ik95B3v/NGY
	+6TM6Hq1cKFyO5c06LpOcP4W34OK9SU8BP2osirdWWxqr6+4TlJhQQlhnf/bCSy71aX8ys+fmGF
	gmTPFPSyQ2Q/F5B/D4yDUkN4rgNtOni2KF8ebjQYca/fxw/8r1nW/waWg==
X-Google-Smtp-Source: AGHT+IGsOXWQeC5FSdn4GRuGdX/IYZf059jDkLdoDyj4722cBDgzK1PRC3hXtFo86vcTefYWAcqREQ==
X-Received: by 2002:a05:6512:402a:b0:543:e406:6367 with SMTP id 2adb3069b0e04-543e4bdef29mr181877e87.4.1738097721446;
        Tue, 28 Jan 2025 12:55:21 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543e4d1cf69sm32683e87.29.2025.01.28.12.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 12:55:21 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 28 Jan 2025 21:55:19 +0100
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/4] rcutorture: Allow a negative value for nfakewriters
Message-ID: <Z5lEN8WdvPyq7dRs@pc636>
References: <20250123185828.460836-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123185828.460836-1-urezki@gmail.com>

Hello, Paul!

> Currently "nfakewriters" parameter can be set to any value but
> there is no possibility to adjust it automatically based on how
> many CPUs a system has where a test is run on.
> 
> To address this, if the "nfakewriters" is set to negative it will
> be adjusted to num_possible_cpus() during torture initialization.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d26fb1d33ed9..6bc161e1e8ac 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -4050,6 +4050,10 @@ rcu_torture_init(void)
>  					  writer_task);
>  	if (torture_init_error(firsterr))
>  		goto unwind;
> +
> +	if (nfakewriters < 0)
> +		nfakewriters = (int) num_possible_cpus();
> +
>  	if (nfakewriters > 0) {
>  		fakewriter_tasks = kcalloc(nfakewriters,
>  					   sizeof(fakewriter_tasks[0]),
> -- 
> 2.39.5
> 

Don't you mind to take this as well? It is needed for:

rcu: Update TREE05.boot to test normal synchronize_rcu()

--
Uladzislau Rezki
