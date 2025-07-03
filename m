Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5E1A2545;
	Thu,  3 Jul 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556970; cv=none; b=nxxTzpnZqHULpY41f1NqEgMbmdGTLv0GOdAFLTaeA0lOcKq61HHaBlYxb5iaZwGRABmp82D/cq58LYf56HfMnT0oiX/O8EP9wOTtQrbJQXE+647cG2cdn7V826dx1GEtfNbKEvLrkMcLM6BrDjrwPLxhqB0f0oDLnSZWlCN+wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556970; c=relaxed/simple;
	bh=2G5I9ZzG9yjrij4WFXM4JUOGhKPUcmmPVs9pnSIs/Wc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meBfazJctDD7B4Mns+P63NTQon+jG91r5lHPI6XFpLjIccMcCzVV7eAvtzweW0EsyQvZ/bE5B9EGbqoeVEQbQpHTOm5m6xh70xDo1OkDTxm+6/ecGG+s/DPN9A7wkfK8/y/BlPSH9MQ+DD1C58mIq8nZH0ILfAThLixY89OnLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qwb9gvWJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwb9gvWJ"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5535652f42cso39837e87.2;
        Thu, 03 Jul 2025 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751556967; x=1752161767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HApDpWOeyUX3Z+9UGcv6amhDxGy0QeLAJcPFfZICILU=;
        b=Qwb9gvWJV6WAIzEBvmCKJoXcTojIHl1FhWlS1R73wavTexunx7fUyHpfldcHrAWqbQ
         xBljQAG3P813uUaHmatLoW7mYio5XZIj5a6uiJrjfTgnL7qLFgkSpZ150JxxgRL2W894
         AfUF4/a4z5jXtet59sQwb7Hzcl6r92WK2B4N1zpEnbhO79OqHOoO24Ay3ZFyoYCA/VHf
         UbTjnEbmDjbjHeCGI5dRXu6gMkrEKE2m/YD14ANG9m+vD3obG5kwhjgakn8TUirAytbs
         4xaBTMB5lu8iqkU/Qy3Rjx+Q5yYCEvyBOTjmM2qucWCJf2Rd3VFeISA2/5140YiRsxvs
         AuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751556967; x=1752161767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HApDpWOeyUX3Z+9UGcv6amhDxGy0QeLAJcPFfZICILU=;
        b=dZayrA3BfeJB58EH674iqPv6a/AgMTYTH+ikhd0YxYbHdJ9xhs13EbSoRpCeZ2P+T7
         jYQTgqiJYKNTTr2UFRYRkkW9mVj1hFTFuLnpMc3XPJIAoENHr9g4jUIom5YwK5LUStg5
         cOjI068Ec/isydY8RkXxbBFtt7YeAbZtSnv3aDeTwZqKqMpVl3c8aFVunL6pOXZXfV6v
         AKtnTKvE90WpmvwzxoAdenIkvQlhTIoBEgZ0j1gONVNrLjMIXf3JrpuJtHxVRW1ddFaV
         hBFW1ND9UOTzRxoDpehvNln+OLQ/MfINdOFZSLr/E/lwxhm1RG2XpSBhr2orONW9cxYt
         ac7g==
X-Forwarded-Encrypted: i=1; AJvYcCWBiIEO0TiKvWitTu+VrCtIHpoTzTB3CMRh/+mO9dJLCDB6+z9YHf/hVhbcwCE+cKNtZLavBeyo/cmpQCg=@vger.kernel.org, AJvYcCX3wm/lKSdiYXVYA3UWn2iJMgOQVTBAyByE/bMkzaj6Cinr9RTEOv3oCxZTJGhQV99aAV6o@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJqGHt/DuMQSSx92Zt+QFi25zpGTcVJLcnHn+3tcgTDhgyOpS
	jwelcKobPFnTQ9jR68NIwSyPrktc5QF/uSyCkOkQQ4xUP44anTPMrSOQAipGHQ==
X-Gm-Gg: ASbGncvO12Pbm5HgzaI1KngwRmnbTveUzTGRuzZ37pxFidXfucbBTUAl/aUYydvLOby
	wfhO3gLYTbVdm14f/M04vmW5GaYMUQ3r9zomphK8wuUEyK8nvFRq7WC5YHjk7CgtVgCGqj8IpVj
	zYdoj4GPJBQ78mvYkouQWejLN1kVdL08RwHRCCJ6UHyVssMka2t/JsfHKPLi0dL+zrwnDKW0+7A
	U8a5IkNQlLpuSwXqS7frvXrvUtNNcKoGesNtjlQF13wRASla8xD+nQzMmqLHDSfDCAXjGp+9xIW
	xMVTI8mkZzGp4vGXLjX33lD0x2Eu6guxaVqdt52FV3G+ijAFagZzN9IFV0oSkd7EUhcAlj25vRy
	jthowWYG54bk=
X-Google-Smtp-Source: AGHT+IGfIgmXFwoivrCu2LKr0j0KhwMIyS3oiIX4QSGJ4eOg65zgCZhe6DcRajyDGesAQiwgpUIt3A==
X-Received: by 2002:a05:6512:1104:b0:553:a64a:18b0 with SMTP id 2adb3069b0e04-55628344807mr2818073e87.42.1751556966260;
        Thu, 03 Jul 2025 08:36:06 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384cea54sm5685e87.247.2025.07.03.08.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:36:05 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 3 Jul 2025 17:36:02 +0200
To: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 2/2] Documentation/kernel-parameters: Update
 rcu_normal_wake_from_gp doc
Message-ID: <aGajYsyMTAD17WIY@pc636>
References: <20250702145938.66459-1-urezki@gmail.com>
 <20250702145938.66459-2-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702145938.66459-2-urezki@gmail.com>

On Wed, Jul 02, 2025 at 04:59:37PM +0200, Uladzislau Rezki (Sony) wrote:
> Update the documentation about rcu_normal_wake_from_gp parameter.
> 
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9..f7e4bee2b823 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5485,7 +5485,8 @@
>  			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
>  			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
>  
> -			Default is 0.
> +			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
> +			disabled by the boot parameter passing 0.
>  
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
> -- 
> 2.39.5
> 
Same this one. Are you planning?

--
Uladzislau Rezki
