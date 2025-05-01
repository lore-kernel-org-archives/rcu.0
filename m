Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06C2153FB
	for <rcu@vger.kernel.org>; Thu,  1 May 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125721; cv=none; b=HcLYaMD756P0KjoPo/kbcgZnALblY3QwMFZ/pTPzIq2O5D0lHNmMBNuYS8U1zZEoHJ/Kuvdrq5hkBrYc5s8PcVRQLjY1FH8UZ6wg5Qzp3IdqcarTJoQBmEJ5lXKotuat+nDHQdRCV5jI+Gvb2EXb5JSGeR96UA9kT4VgmOmIkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125721; c=relaxed/simple;
	bh=/3TdA+DA26xkvpwWd9NNx7MPzUtvHZyDWxZl1Qz93uw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=n4pUdeKGp6fakcDUL+y8jhraJvP1h+z7FgKp0PmstzRa66qIlErkGU6zaoi7gAgBsz6ORzWVZZIFWn+EY9zWcYlfG0L9INN79TClwn5a4X/9ZUNYYmhbRuAwgD/HoM0/BmejBHRxFEhGeqqOcvlfePbcSc68qgGKeXgBcflhfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=g4b9epPc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g4b9epPc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5e39d1db2so87698085a.3
        for <rcu@vger.kernel.org>; Thu, 01 May 2025 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1746125718; x=1746730518; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZXCYu2EcscUrjQT548d8k6EoYc+DAzNFjTB3gyMei0=;
        b=g4b9epPcV9Oiz61gDrD4BnRc8PfPkt6wI5woQg6HwotngER8u4tw+sMPVmTyCAjL6A
         WGHovPGM9+USqumpbZAYMosuwmg6NKJ7TAm0WIU3HvOGVdV9kTusrvcBEZWA87/jGaC4
         47ODxhnSJQi8/EOJDH+pj1icB+hSBLEE3QBfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746125718; x=1746730518;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZXCYu2EcscUrjQT548d8k6EoYc+DAzNFjTB3gyMei0=;
        b=eGex2XUB30t5GHvwjIiAK/Hh5ZBZuxn0lPx9q0kafYFfL8ZyKzu3l1sKG6hs5Hq5Lx
         0Ej5mVE2ywl8FrCxkg52m0psvRlutqPJQYBF7BO2zN7Io8AXS4/I4AhRBVtaZWJNKa/z
         9tfqO7xcJiWahNt8TI3CB0ylbY/a4l28GKgsy+o4Kj2ZC3TIn9bvo35d5wQgGUx2M6+M
         F8Q8jkrQguxC2uKHJP+OXJ7kP/ncOIUmxfV77w4IXDvJsaYJ0WsMZVO4azP9yVvxWCbc
         LZXOH+xTLqeVVaUvgjRI2E41FQJcuc8VyNYrYZTnabkAHl+5O7ur0H486MROHIh1sDXZ
         qL7g==
X-Forwarded-Encrypted: i=1; AJvYcCVyA1UkoJpTD7n8LyErwF0t8CwJApHzDD9j+J/p8czqltGNLudkMQrjfq3IxgWdij0YDsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyffPYxZ2KDUgJB8M8Rr0P68Kq4h05bvCFEZoKcUq0ALXQ0Q7yv
	EXlOaJ3IFXLxXPB25U6mK+/kOT3nSxTCMSqzEbzGNjRqjx5yQ8dLliRyIKCr7IhdufAe5UOw1DK
	yyk1yiQ==
X-Gm-Gg: ASbGncuztR/rSn7zxAqI3UkCguN9F5rVTzunEUM+h+hUCjelqnm4PIEOohuBeBCCLz5
	KUYdjYzUt4deG3/u+/7OYQqzlNl9/MdoIzy0daCmHtgwYEsVQVFNuJ9G2hkE9BMviZFPzRZC+ml
	7CZtdiDt6fHi+UnAJBvfvalL+kLXcJ/tsRupoinoeTaopRrYQMaGcr5kF4AzJ6UxuB+kIbnBTmJ
	jByWYvkeKWV2ha5mMSb9AxXTPUyjimsQzihshR6ciF5U27JiyHr9wpnW1NYeJWCcQv8kqDAdMs8
	o3ubP5AA6LFRlzN+KhbFxNvxIhCL73PL7DTKClKuiwSJEspkog1RXAVsvfYJ4dF5J5zADQ==
X-Google-Smtp-Source: AGHT+IFqvgE58rEYlaz++lzz39Fq/n/d7EKd9t9wJ6KmHvorurVe7qfMj9pKYFGZP1MKsZIyVjr8mg==
X-Received: by 2002:a05:620a:2916:b0:7c5:3d60:7f88 with SMTP id af79cd13be357-7cad5b36180mr29388685a.16.1746125717805;
        Thu, 01 May 2025 11:55:17 -0700 (PDT)
Received: from smtpclient.apple ([71.51.182.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23b5b70sm79556885a.17.2025.05.01.11.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 11:55:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Overnight rcutorture tests pass on ARM64
Date: Thu, 1 May 2025 14:55:06 -0400
Message-Id: <D5585BEE-AA5F-49F1-A861-319313983172@joelfernandes.org>
References: <81416100-45bc-4dc9-be17-21e2973410c4@paulmck-laptop>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu <rcu@vger.kernel.org>
In-Reply-To: <81416100-45bc-4dc9-be17-21e2973410c4@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (22E252)



> On May 1, 2025, at 11:47=E2=80=AFAM, Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>=20
> =EF=BB=BFOn Thu, May 01, 2025 at 08:25:30AM -0400, Joel Fernandes wrote:
>> Hello,
>> Just want to report that my overnight tests on [1] with rcutorture on all=

>> scenarios are passing.
>>=20
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
>>    tag: next.2025.04.29a
>>=20
>> sudo ./tools/testing/selftests/rcutorture/bin/kvm.sh --duration 720 --cpu=
s 288
>>=20
>> As such, I am planning to freeze new patches for 6.16 (except for maybe Z=
's
>> patch fixing the nocb warning) at this.
>=20
> Very good, great news!!!
>=20
> Could you please from time to time test merges with linus/master?  If some=

> merge conflict or bug appears, it is good to catch it early.

Sure I will do this for my next round of overnight testing. Thanks,

- Joel



>=20
>                            Thanx, Paul
>=20
