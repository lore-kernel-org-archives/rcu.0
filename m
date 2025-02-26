Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89522540A;
	Wed, 26 Feb 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593791; cv=none; b=pmpo04EYBp0CCB8gGE+KdDWK2FDDyQU0EudTamXxd0tosW+pPhbXF50t5UdZAcRpqDqFEgEMMOgq0Ov2GIr1P+OpiZ1wwHRnHGeN8B6/B9KB7e4l6GurK3jBOuqZtuCtO0Gm+d2+KtIh9Dr4Ahp/BveSFX2bHJdlg6kLhiyMFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593791; c=relaxed/simple;
	bh=PNiyuwVdpLNUJENGkyF6Mxf17ggDLh3V6Qr2VnnJecQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5myC1x36AN/8tCaLUaWwVm013K/teqSItYz7U3cGqwlfeWdG8sZH83JV4WmU0FXLq4icKxpwAP2ef7jLG5eYaeJLxbuSeIBLEEdJpFYRbCcuF4xLUBp3sm4G8B2nLQwHxQzMfQ/cVyJ//bDBaQJfhEuY5x4gyNE7VUmCZY4XX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwyCj9Fk; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwyCj9Fk"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-548409cd2a8so27316e87.3;
        Wed, 26 Feb 2025 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593788; x=1741198588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW8IjnVqYAnoyypVc25LwdWGOG0ZhAp1qYJ86wqoM0E=;
        b=hwyCj9FkZl4/QW4Jciur9RaLc3rR39ebEgVOlZOm9+De5dlYu5TO6e8IqEO34x4pmD
         pTr5bqCvR2s3KJ9KBPcsKmcxHxajyj/ol1dCjeriwLRouZvWbbkmEhrxmYmqKkfSFw/Y
         Xv6qcCUgsGFl42Ue2m0CheUAKvQogJH6pQGXw3MwceKHWhadquOFdlm6f0u01pg6UBoI
         q4tIdcmrogzoLU1BLyjkIdBGZ7eKBplSgmKBZSdzgGe5CdH/6Ir1Kngv8Ph02VRIxaaQ
         JdykDD0vwOBz0GJmUdemmbygvFc8cvpGaX+Ylox4Irs3WpW+QHswUk/V6IttA4WXwnAW
         WqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593788; x=1741198588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW8IjnVqYAnoyypVc25LwdWGOG0ZhAp1qYJ86wqoM0E=;
        b=ugKNqxW+twz2l4ge2hBpSNYPZpDbOo2WPXlV68L7tgYfXLLo5OglEarsmKQbwqFO0k
         tqOQhM6OZG1js7P0vdJA9R1QE71XQEBUHN4tAPgnGYZb1xjmzfkeghqdh32JfZxGnTzT
         TLmLAIMa3EBK0X/VkTqT5zxoXQW4cTvVGVV1rniBSLdcj9P1nLXhP/xwkwWpowFs+vu8
         +0Lv2uCeBWIJmBgP+Y81B8VPPKYMJK5yXkvtzdNTnwbzzay7gfZmLdDfB/V7x+euuqIX
         4kNfS0+YPZpxABR9oRa44kore6PDv25/csnpHt66By7HhHswSuogILx89KEywrqI1yHV
         MaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2yT4lFeA7N/dtra0IfmxuqWIenD8YUOpnsh2dbdxY4FSLTudzANRc0WLYt2rXDVT/B9AEspt9FsrPowQ=@vger.kernel.org, AJvYcCXQ0CKKDPxHLm7qbi/vZqjMKvnNhkQcg0vsFOvDWW7lZS/6+ZmUmxY9m8tf0SIfCUVvKcuu@vger.kernel.org
X-Gm-Message-State: AOJu0YzPprN3KEiDpSvs2YwlgzUtTsfYTgafvYs6JV3NbP7NvcN+uqf+
	+w1fTVx0jMdEMzyFG+lmAiadCIlAL9mp0Y00e4LZ2UfojVsC+OuA
X-Gm-Gg: ASbGncsA9YSn6H2ysCMiAxGubAVanb3SIFAqcrvT3Tgo5qqzm6lbwMbYYOGXMTqTDIj
	HFePFW5HTvD6twDACPTJ4hjm1Il52yKvjUKkiEepQK1JgEzhjKIPvgcLUFxliHOyHrNFPS3KCTh
	haA3RWt4Q5aE72vsAVJwF1H1NQOwwHEdrMohhNcP75a1Jma2xI91uaWrGqedKLwuXBNyxoOtnFS
	cOonxA4CXdRwuDYEFzaASMPtKVigKTcmq/pQ4RW7hP4danvWCML1IG276vfuB1CpaGLICIStm5F
	mLoWpzXMd9wgrY38/9zSkRrZxuf4araLkA2f10HE651/5PMm
X-Google-Smtp-Source: AGHT+IHRLmoBUoY4FBdsGXt2Pz0LRZDOQPRhjMxYUhfsU9pjgEpkUYNYDod+hStyOkPEKqMYoc2UbA==
X-Received: by 2002:a05:6512:ba5:b0:545:e7f:cf33 with SMTP id 2adb3069b0e04-548510ddc55mr5274273e87.28.1740593787740;
        Wed, 26 Feb 2025 10:16:27 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514f9dc3sm516092e87.215.2025.02.26.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:16:26 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 19:16:24 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/3] rcutorture: Allow a negative value for
 nfakewriters
Message-ID: <Z79aeJn_bC9ptBD4@pc636>
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225212409.GA1807836@joelnvbox>
 <Z78lNRKjLQKigyLw@pc636>
 <a26d4cc5-ff54-4f9f-b2df-aa423c112487@nvidia.com>
 <a3892fc3-f0a7-47d1-a7ea-d82bb7c88d05@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3892fc3-f0a7-47d1-a7ea-d82bb7c88d05@paulmck-laptop>

On Wed, Feb 26, 2025 at 10:04:35AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 26, 2025 at 12:49:41PM -0500, Joel Fernandes wrote:
> > 
> > 
> > On 2/26/2025 9:29 AM, Uladzislau Rezki wrote:
> > > On Tue, Feb 25, 2025 at 04:24:09PM -0500, Joel Fernandes wrote:
> > >> On Tue, Feb 25, 2025 at 12:00:18PM +0100, Uladzislau Rezki (Sony) wrote:
> > >>> Currently "nfakewriters" parameter can be set to any value but
> > >>> there is no possibility to adjust it automatically based on how
> > >>> many CPUs a system has where a test is run on.
> > >>>
> > >>> To address this, if the "nfakewriters" is set to negative it will
> > >>> be adjusted to num_online_cpus() during torture initialization.
> > >>>
> > >>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > >>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >>> ---
> > >>>  kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
> > >>>  1 file changed, 16 insertions(+), 6 deletions(-)
> > >>>
> > >>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > >>> index d98b3bd6d91f..f376262532ce 100644
> > >>> --- a/kernel/rcu/rcutorture.c
> > >>> +++ b/kernel/rcu/rcutorture.c
> > >>> @@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
> > >>
> > >> IMO, this should also be updated to reflect the possibily to set it negative
> > >> and hence to number CPUs:
> > >>
> > >> torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
> > >>
> > > You can set it to a negative as well as to number of CPUs or any other
> > > number.
> > Sorry I just meant amend the description to something like "Number of RCU fake
> > writer threads (or set to -1 for NR_CPUs)", so user does not have to read code
> > to know that (and update the kernel cmdline params document as well).
> 
> Should we also adjust the string for nreaders?
> 
Makes sense. Both options are adjusted in same way.

--
Uladzislau Rezki
