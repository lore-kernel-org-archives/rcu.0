Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D31F63D5;
	Wed, 18 Dec 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558876; cv=none; b=hzUKrZh9GtCuPCD4gLicP1NOZ5oZNUSGtXl0Dj/xnHQyhThFNBnOzY2mpA/4TEm2nPnaFj1EQ5qb1qtuXriyBR8G06zkm+QW/E5SDOBk3WAUdxEMtH32Ur9pmj79l6zupJ3Gk0rab3efGVqV5oY2uruYmfeA3GSgjD4SrTIfz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558876; c=relaxed/simple;
	bh=DV8xkB2+FtSYxFHWBQPZibmNscaXLRqh7ieW5ixBhao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7/PXAGazvIubJUZSdPkp5XuCW8C75Y7Pysy1+Y9Qg2GqCiMgIIAJifoUriP6gWHk0EEiHtnln+BtYdtkg8B6K2zHtEPTdsuVk184xu0JFRyjQqMcf/auU4PaUGFn/oy2j20Zkhf88A7TxoxPBlcCR4Ar0vePr2auBGiyTrR2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty2X4NLU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty2X4NLU"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso165390a12.0;
        Wed, 18 Dec 2024 13:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734558873; x=1735163673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DV8xkB2+FtSYxFHWBQPZibmNscaXLRqh7ieW5ixBhao=;
        b=Ty2X4NLUKGpSppOq/047gmNuCvzs0eiulA+6okOp0gZqI84/ZwwdTg5k5DA0MZB+rJ
         hNa4evcFY+5UCd7GnTLiy5xNZQOVT1yqXRCfo2dwxrdLnL8HRQX9y58jElnDDxYzXkNd
         8LW0XlYm9FDVgCycu3FOuPmk2TmpBGkrTJ/EyJfow5f9UfYNauayvnQoPdUVqhEdAOZ+
         QzyLHpm067aqvEUtPBV8I0nq2zkO1nzr/jHKjFLivtkFxAW1h/QcbvOgSaDEL8ALsIvz
         21Ys2AnCiaw7+9yqorStv9+84WuU5eN3EpJCmoXRBs2R/Lv0uzMmCIMxl432z+i5+IdO
         2e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734558873; x=1735163673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DV8xkB2+FtSYxFHWBQPZibmNscaXLRqh7ieW5ixBhao=;
        b=OToncUkEF+uOI0REeja1gGmqkAAZqp3IVFx3gMZEe3qFCtVW3FhMsD3NhgBOtNWnjg
         38yEha1taRehYTvECozzKkaVMcglHbfwuI8yTPzFRUz0YpIy5oNAIbQtMglIypGrjI+J
         efSApGXnTKf7htTpKFCAJ6RrCS318rYzcE/h5Wb7Vvb1KjtQpsFnq1d8mFNbCl63M294
         kHBgS11Z6BlmuALNnZji1+UuSZ7vqpulditXRFgpg0WXH3VHjzHY38XRaKmzG71LDUcp
         4jbFatdSagG2tfQJrrEO3q3cNlL7qg15uMZXJ79Ql9pTsEuGwIDcOnCU5luavtNaSkPI
         RCVw==
X-Forwarded-Encrypted: i=1; AJvYcCU4yT1Dobx5kfhD7cIbnUAuI66KzpVSNji1Qsxs/c9UxwIqLuRUtgai2K4/+DEAOGf4QKsZFPqoXr5Apw==@vger.kernel.org, AJvYcCVhvvCbD7edttvqFjCeKEnyUlCj51f8IM3D1oftBOiTYjbx8hhLqNe/TBUIysSK7lUJKEEi@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmOfbUgroUtlhM1xOLcPyotMOS5LHooX94DK3o+hQbKXmkeaz
	cTgF1q5yy3hUipuRGaqR4xgS+YEuP77zI4gKJ09ZLVf49lAfD5fWdINtctwJuzF3ejuW8FfLsNv
	U+9qjJiPKjDY0+Js+//xwkuA8ILHj6h2jOyE=
X-Gm-Gg: ASbGncvkUI1GKtQ901Ty4vpkUWoiWYIbyG9o3+uP31i7s3fAJBmoSqmSXNPR6t50v77
	XKLqZYnFTwYFmfnOXMFRWBIQC1QKz+UB9CDxX+po=
X-Google-Smtp-Source: AGHT+IE7sacDI6ZebwlgOfGtzs3fBrkLc+FiqkAnd7f8d2b9/kQZJ5juVInQ9rcaICMkhLQnNH8E3AneocNk28YWXt8=
X-Received: by 2002:a05:6402:2347:b0:5d1:1024:978c with SMTP id
 4fb4d7f45d1cf-5d7ee3771a1mr4302350a12.2.1734558872672; Wed, 18 Dec 2024
 13:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d9330edfca0fb34c69a68c56924fa0b074b26d29.camel@physik.fu-berlin.de>
 <CA+=Fv5T9nrQjGHOR+42tfgT723TJGgyVqBY7CwY4L-gYSoWTag@mail.gmail.com>
 <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky> <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky> <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com> <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop>
In-Reply-To: <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 18 Dec 2024 22:54:21 +0100
Message-ID: <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: paulmck@kernel.org
Cc: Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

> If I understand your proposed changes correctly, this could increase
> the amount of time CPUs spend waiting for for the csd_data to become free.
> This would be a very unwelcome development in some quarters.

you're probably right, this might not be the right approach.

> preventing it from happening.
>
> So what am I missing here?

Maybe a per-cpu variable is the wrong way to go about it. I'm trying to get a
better understanding of why, even quite simple, structs get corrupted when
accessed by kernel threads. The compiler may be at fault, but is it possible
that there is something else going on, which is specific to alpha and we're
seeing more of this on more recent kernels which makes better use of
threads?

/Magnus
