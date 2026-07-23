Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84D48C402
	for <rcu@vger.kernel.org>; Thu, 23 Jul 2026 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808387; cv=pass; b=VbWyJdy5gZdqNQC3DxUAQrqRGGUHxQtBpjMtjGZyKiLdimTG1VQm/WxLj3sJGPiVYuSKrPkmNfdWgRL7rmT4y/M+t2w1NgQuVmQLtgpn7MqpsyAhHRzptuvYLfEoXplot2J7FaUJHBBfZcQ6m5Yfg4JYinsbP50iQsY4GzRcLwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808387; c=relaxed/simple;
	bh=3vlJv6FSf1aMVbnSCASc4/+DJaUBunDB2IB1X7BaEeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyQYhdajBBscxUlYFnJe9Z+A9LiK3iYoTcnfh/deGhgR7ugDo4sMiR5eh497csC9bC2Z5OnnQRHev4W1PzN+Jyr3jeGBZDWtEd+pyGRLPuQPenHoj3U43W5QkwAsG0oejoqzD4glEIaiUiULw5kDpUG7X4usppk10A6Uyot1Xhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmsDj+Wm; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmsDj+Wm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdce28edeso1232305ad.0
        for <rcu@vger.kernel.org>; Thu, 23 Jul 2026 05:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784808385; cv=none;
        d=google.com; s=arc-20260327;
        b=gPfz1JaTKqKHDMsTndBtLpZi+5tl4nPovTmGaJRUimPi95YPWSBjtG8nbELu4OKx81
         GeqdXS9xJGgVn0GZ3VjBHru9LA2AusihdEOt3NCdr4nnNE6hPk6Jv415xoXlqON4ntD4
         aAPE8BJCLsqr044MCOilHpAYqS3kD6bhEgp1gqRlRnS3Ql+nDFPSj6qw9ZavVH4NUiB5
         jaOnznC5PZknS+p7QNyQ0WfYBCpT26gNOFgY7AV12xamdvcbzaoW2rXzzw/yB5WuJwCU
         wP3rcE+kLJGRRZb9n4pTWG9I26HgORmFmb0yJN+RTj7FAlM6buukZQ9dxvshyGBRYMeC
         gQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3vlJv6FSf1aMVbnSCASc4/+DJaUBunDB2IB1X7BaEeM=;
        fh=j8lP8q/yS8SgSVkXR0GmhAmkL0gUsNus5RPHLR9g01E=;
        b=IAOh+x6MMr5dCafNEve6K8Cl66WUQ7hFBzGRhJA7v2CqxC+96Uuhit6yCooLlktnrA
         yeYvXtZpXpXpTSz+GFaI5SnZVCNALhLqxj3QixUU08DsV/ntEgtVJipOu1d+P5HUlMyf
         B8d/RmzXn60pGaOwq2EfBMTG4N/YTDg2lgbFw9wIRS4xcV6ktAy0q9pEoRSAMQNA1ohA
         8uPxp24GrO2ke7hVS8ucF4Fbe6G6fdTr/rgf3j5tRb/gyTZTjF6U03oHygLALLO8OWsm
         WPdGF/JbtmnB1vkoLPj7mC2Ug6A/AJC2snmaRgl1x5N24XvmhP/b61f+OLhY2fDQiizy
         aBmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784808385; x=1785413185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3vlJv6FSf1aMVbnSCASc4/+DJaUBunDB2IB1X7BaEeM=;
        b=MmsDj+WmZJ3amnl9ppOKjrpkUBqFCzk40LcVmzfyH83ZlgPaULSqdIK15a5qHha0vv
         Y0cJ7hIVWICgxK3zyU/UavxLEd3WruPxfo+krEryrN5F8OEq1NcDc7js1SHPJvMoGUcS
         c1UA5pZqZZM6CshwOsShnIKJDtAgoGxzz1r5LYuYJjaD4f1hOt+fnII46X0SBjVvYcYg
         g6RuTvW8pwiz2xlugEMlznC+u+VtDkBsqyjgc+ovKHrTMqhHqd2rVMiVTW3hE86QU3U/
         20cEZZ+ekMHHe77vqhSUT9aSarrpKJyUYgXxTQVlO13gYyw5I2zRTmWOYmjGLISWkqbn
         V0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784808385; x=1785413185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vlJv6FSf1aMVbnSCASc4/+DJaUBunDB2IB1X7BaEeM=;
        b=SYyenH1FYXA64Nh4T2TVbGRWuGofrrzzPhG1FV0rXFQZ6U7vr4yTc0/EtFUjpGbDSD
         j+BpOvEQF+HeSCfC2Vce2VUdaZdR2a6VkZgiV1HnSULKRdIaoxxIYK/ZPAmHUGqlrQOo
         wYtWyYsIVkwbyus7rmrJrk4JyJniWmixzt1tu8Dy+IVtTzTb6CRX1h7gMUe9FPjGCgXG
         MqOUwKlgByvk9++3OFH3A1Pdl/p2XdkRzMVZgO8mRHiG/lHJytrWiKHREd76MbCIOSvm
         Z8NbXTvkKGJ0JKo3Rdoub2O4kLc2JzkmawMCKQlD8m1/16LJxRAYepKGkWf/kvoSaQYK
         qdqg==
X-Forwarded-Encrypted: i=1; AHgh+RpukyIyuPxOrd/W12mhkmgTWKJH9r0Ux9qQNAoTff+Q9xqwVhSYqmkT9Xv+gJcNzYe2/is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6RNA2+uDYOm0qWUeIV97+iUGSCrYqnCj1PPPPrIgcI5Xj++m
	IpYr4bOlBtqB5GmhzVq6JnPwIEEJIaYcNhI7rkOQ3tza2CnFCGwpU6DLJN6wGdGH0yUdUpqjuvN
	KibMO/nZ0ADpjnKgFYQL3wpxqKye/1EY=
X-Gm-Gg: AR+sD11cUWQE1g12Mts5YwOqk/HncRm3eKMnL9xDI06C5W22qmzmhH1xR1J4twjK3I8
	RwjT3kHeCuqkAGZA9S+OuUG+QjBiGB34PMUZJ8DeGO38NQkoNJorcvOorw5LDtupt66UxqSS3pa
	65KWoWZpaRCfRiwazAOUjeK89QECRV0L+a07EtUlQtd69Tz24JbMaG1kKob87FYdmFsGO5EWzEc
	jYMm7bJ0FBFsp5OB7bSPoNcN9rXZ98Z2RR9ode9iOqhtsuyqhYfs1K1No/VXP2pQumGKKDYYTRr
	yqF0Y/J+hg+xwzuVyxUEjG6bcv3n+80ynZlUpAiJFA5yoHqa9uTBKSJNIL6PqsgnvfnAdEGYleD
	fnuNO0pcPPsMo
X-Received: by 2002:a17:903:4b2d:b0:2cc:e3b6:f305 with SMTP id
 d9443c01a7336-2cfa6c59d68mr27112065ad.4.1784808385545; Thu, 23 Jul 2026
 05:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722144931.1070312-2-phasta@kernel.org> <20260722144931.1070312-4-phasta@kernel.org>
 <fdcff2949180fa40d0605866fcb306781ddae4cf.camel@nvidia.com> <73981717a8a609013eaca197a41a741c52bff44d.camel@mailbox.org>
In-Reply-To: <73981717a8a609013eaca197a41a741c52bff44d.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 23 Jul 2026 14:06:12 +0200
X-Gm-Features: AUfX_mxFlBb9IDtLvxq2VlENXeNPc_YmNc4BAainSjkN3awVvg2ldaZORrjacic
Message-ID: <CANiq72=zQkkQWedVZ-rtCeJBbRxhwNJTLxCBD-6um4OMuFJGGQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] rust: error: Add ECANCELED error code
To: phasta@kernel.org
Cc: Timur Tabi <ttabi@nvidia.com>, "qiang.zhang@linux.dev" <qiang.zhang@linux.dev>, 
	"josh@joshtriplett.org" <josh@joshtriplett.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	"delcastillodelarosadaniel@gmail.com" <delcastillodelarosadaniel@gmail.com>, 
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Eliot Courtney <ecourtney@nvidia.com>, "adzicmirko97@gmail.com" <adzicmirko97@gmail.com>, 
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	"sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>, 
	"tmgross@umich.edu" <tmgross@umich.edu>, "frederic@kernel.org" <frederic@kernel.org>, 
	"aliceryhl@google.com" <aliceryhl@google.com>, 
	"daniel.almeida@collabora.com" <daniel.almeida@collabora.com>, "boqun@kernel.org" <boqun@kernel.org>, 
	"lossin@kernel.org" <lossin@kernel.org>, "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, 
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "dakr@kernel.org" <dakr@kernel.org>, 
	"tamird@kernel.org" <tamird@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lyude@redhat.com" <lyude@redhat.com>, 
	"lina+kernel@asahilina.net" <lina+kernel@asahilina.net>, "ljs@kernel.org" <ljs@kernel.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "work@onurozkan.dev" <work@onurozkan.dev>, 
	"urezki@gmail.com" <urezki@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>, 
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>, 
	"fujita.tomonori@gmail.com" <fujita.tomonori@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 1:56=E2=80=AFPM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> Ok, pulled it in my local branch for now, thx for the heads-up.
>
> I see that your patch is from June. If it lands in drm-rust-next
> soonish I'd simply rebase.

I will take Timur's this cycle, so it should be fine either way.

Cheers,
Miguel
