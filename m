Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E8307AC7;
	Wed, 10 Sep 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512945; cv=none; b=PLOSCIHuLf8wvJR527N9KWbjCTrGb8AegDiJpZZc/jxeJEPm+PnOcAedIVjnCj1wE3cUHaKTdq2OEbnmL7/K7EB73+BZFLCLcYwVedItSnpumke59XF/4xmZ2LLm695GbcVcjYdpa+kGkvjh1qc4A++3mchfRZguPT6rBVaDtsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512945; c=relaxed/simple;
	bh=F6MeJ+cDwC+7Q6k/p4fv2tZVmfgdZe5zJwX93hQB5k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkY1BAotHMtOcnmL+hd+9aLKAvXfHShhxLk1fWTbpaBozzkz19Ca8yiJO63AKZ9om+C8okNAJIQWJA8LQYt0Q6gOVVOvyR2GQe1BR3iSnrLKBs0SCiPaRj5tds9kt1h/lw+D5RSXtdLl3qh+bNAuqQjvM/gg/odvWoHrNk9CQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pcAD/Cnf; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pcAD/Cnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757512918; x=1758117718; i=markus.elfring@web.de;
	bh=BLqchruhwBDHpBW7capEWmz0EDvDZA7G3NF6oWFsnNQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pcAD/Cnf4vWpyy04uOx9L2Y2oiHX0Ao0Bb6obzrJ6g0IRYQv1RlPN+czFjKKKmGW
	 gei3Mlo3ySc/VZDIbcEF6jP0MkNBsY2p0+HbWhSXhIhKPePXCVK7Kbw2jwk1K4qgu
	 xCE0EdxrD6FCe0iCwoU2BXyn9zbkQqVX4jP0DY0+QMKoDEHralO/hgxBO8X4LmOZE
	 t8yQcfriLRfLtOurzzeexYsEIXCAQjqfl6riZXyjX3+gdo9D22HYD1pHtAFkEKt6R
	 Tmo1MKcfHEYkMDBYMC9vR9vzx1kiZ6hO8+JntqCi3Ywu29CcCJjr1sNY0HenRbVu6
	 4O+5GQZMBCDnqI0qLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzn1-1ueXWp0wcb-00JaKI; Wed, 10
 Sep 2025 16:01:58 +0200
Message-ID: <f4e20f17-db56-4a3d-a673-b7349dde2495@web.de>
Date: Wed, 10 Sep 2025 16:01:55 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rcu/rcutorture: Improve error handling in
 rcu_torture_fwd_prog_init()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rcu@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20250910121427.3757718-1-kaushlendra.kumar@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250910121427.3757718-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NfDPEPdU6wQYU4qU/sSSFoQoPBEv93adZGG1D3R9lrDSURt4fdO
 NIJifhCAMqR3iFN4pN61dUXS2O3LC4Rk+vyFV+7r+8ZndPuwkLUNwl2jxf9ZsMTIeExTrjS
 sjJwubiLt89BOVi7wzL6T476BJDdnGmLhtOmuXMxQSEnysSz84pdSlShlPS0bM5sfWICj8h
 AtAMLVwskInaB+SipOVjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2WNN3UeOofY=;PKIyDvV+GYUZD9hnbmOTcf2ALT6
 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
 kO5zvKBR2k5+CstCUjF2Js3dUvhe210SKJA5M

=E2=80=A6> The improved approach:
> - Check rfp allocation immediately and return early on failure.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.17-rc5#n532


> - Separately handle fwd_prog_tasks allocation failure with proper
>   cleanup of allocated resources.
> - Remove redundant kfree(fwd_prog_tasks) since it would be NULL on
>   allocation failure.

Would it be cleaner to offer desirable changes by separate update steps?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n81


How do you think about to increase the application of scope-based resource=
 management?

Regards,
Markus
