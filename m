Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E915C147
	for <rcu@vger.kernel.org>; Wed, 16 Oct 2024 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045448; cv=none; b=tNDgFTySP/B/NWRznEFljyu7z6giQ9FEV+SrZSQvTZ4wUBvz9Uv+RfH0kAcYVERvNWAG8ykrpd9hrUwV7SkTOmOgCrzMDvLWGTpN7vcYRd0tiLG+zHTZjQ+BaiUDbqvWM3Hac0+RFzw9EyRsz/qy3yEyWUqvCytOGqBpsPG4+dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045448; c=relaxed/simple;
	bh=vkFin8YAkk9Wiv1FM6Rwn193R82QUFJ0lMHnYMg5PW8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONdUJuDqFrr0Hi/t6Oq+WVRSV4qpfrPFwyS9UZTqeLF38bP87hF+45Ptjx+jXeDyz8XMcmrEEOWo2b5h2pQ+I6F5jMXG7I7lIPpZgOv7cQe1TbxKqbpUQEVKmWdK56uyN6xNA5b07X5YYEzO/O9alfK4nxvJHyf2jUocfKAC4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=KdVlktDk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KdVlktDk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460489eec46so67158121cf.0
        for <rcu@vger.kernel.org>; Tue, 15 Oct 2024 19:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1729045444; x=1729650244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rSM5JzEpw8IEvYl8Wi1gclJRID81zECxLDVfM6LHr2o=;
        b=KdVlktDkDJHkWr7HFDsQQHLqYLaHgT1E396S+UnUXghwn7T1HNdjC1PSsHNIcfm3za
         74ThQGHppDbKkl5FmUp03FrB2qv6SCgFExp07/GT0uF2fSnUmr3s5goWsd7YETMzEM0X
         A57kjMF+uUYKjlQOh1Yrvv1j6HhDNJ0cI5PF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729045444; x=1729650244;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSM5JzEpw8IEvYl8Wi1gclJRID81zECxLDVfM6LHr2o=;
        b=fiYqzW+/DdkQIAAlIo0ypv8/DpiJqtsCFs9s9Pgx2Np1KO6F5Xo+oCtnkhKffTM5+f
         CxXvV0aCyWLMmI9CB0Te1gqHkIa+vBis0ojkeF2mtaB1OtHLYcOPThD61NA92sndiytc
         Dr4w9JzviSHzZZUEZGGD0f1tvjhVbdxkDv3ismIwouDV+tUIaoUVeUo2SdeUZHHBeE35
         vOOAF6QCztD4FVD3h5b9za+yWalTGuDu11qQSGG8r4UisI4WB2ag+2gH458J6OMYJoXZ
         gj2+Hh3/1BZ2OhcMu2AirAtYcSYX5l6LKwqpqNpQMBpH43YKfvvZ1FQOIAeBnbuCH4kE
         qjBg==
X-Forwarded-Encrypted: i=1; AJvYcCUmIjLU3z2LwbRs8NGlogZB6R2hXrudw2D8vFEo+LhZt1E7p+hJJefPimxmHEQ+BtpUfJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+AuX89g/13AFWPRDh94iIo1bQ7hnAL7Fo6QuZYI7XsyAO/AT
	Z67KWmJE39O06TVMUrEJwEcLhL0n9oUkgbLHN4EGSUv7wZHl0DVexAzs3Yacg4E=
X-Google-Smtp-Source: AGHT+IFWCC/S9dXsp+A051MHox+o20A3NL3tpfTZfFxD6YcOo1vnCybm1oZluCcvQ9PpRfE9CJMD1A==
X-Received: by 2002:ac8:5806:0:b0:458:2523:c060 with SMTP id d75a77b69052e-4605844500amr232582351cf.29.1729045444189;
        Tue, 15 Oct 2024 19:24:04 -0700 (PDT)
Received: from localhost ([91.196.69.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a3fa3sm12755241cf.5.2024.10.15.19.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:24:03 -0700 (PDT)
Message-ID: <670f23c3.050a0220.1fe46c.5dd2@mx.google.com>
X-Google-Original-Message-ID: <20241016022358.GA117803@JoelBox.>
Date: Tue, 15 Oct 2024 22:23:58 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: paulmck@kernel.org, netdev@vger.kernel.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org, matttbe@kernel.org
Subject: Re: [PATCH rcu] configs/debug: make sure PROVE_RCU_LIST=y takes
 effect
References: <20241016011144.3058445-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016011144.3058445-1-kuba@kernel.org>

On Tue, Oct 15, 2024 at 06:11:44PM -0700, Jakub Kicinski wrote:
> Commit 0aaa8977acbf ("configs: introduce debug.config for CI-like setup")
> added CONFIG_PROVE_RCU_LIST=y to the common CI config,
> but RCU_EXPERT is not set, and it's a dependency for
> CONFIG_PROVE_RCU_LIST=y. Make sure CIs take advantage
> of CONFIG_PROVE_RCU_LIST=y, recent fixes in networking
> indicate that it does catch bugs.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
> I'd be slightly tempted to still send it to Linux for v6.12.
> 
> CC: paulmck@kernel.org
> CC: frederic@kernel.org
> CC: neeraj.upadhyay@kernel.org
> CC: joel@joelfernandes.org
> CC: rcu@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: kees@kernel.org
> CC: matttbe@kernel.org
> ---
>  kernel/configs/debug.config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 509ee703de15..20552f163930 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -103,6 +103,7 @@ CONFIG_BUG_ON_DATA_CORRUPTION=y
>  #
>  # RCU Debugging
>  #
> +CONFIG_RCU_EXPERT=y
>  CONFIG_PROVE_RCU=y
>  CONFIG_PROVE_RCU_LIST=y
>  #
> -- 
> 2.46.2
> 
