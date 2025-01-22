Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736651CEAA3
	for <rcu@vger.kernel.org>; Wed, 22 Jan 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564443; cv=none; b=UFqWlONqYwCwd8HyVIQR1w6JHROogJlrB+yIw8US0aFqDFYFMS1ZJSAoqfYR07FKOU9gJzWf3HqE2vlSnhPCTlmn18Q8duD61FjvTOpnePkJOpfqK9fB/yaYGp9I/KK3LKTWFxQ4v4e7QhJMfBlSIq2x8IHUX1WvKKAoRmg86k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564443; c=relaxed/simple;
	bh=qpMPWh6raFQfF3e/aBGZxXLCSM6GxAKP6GoOYV+6aec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6kz6whAydV7ZzAmwPprbDh2j0yLEIpHOP/uGzQPyNDxvGA+OEDtKx/EHQ7EfNI9lKfdDW9hQo0EbJCROyiFWMbGRNR1dZrob7gb3axnqDryPZvkkQnDEtWdHqn3P1RrYF3A58GTOnbqNgy6oIw18ZPHEcK66mgIgNHBbspB7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=LXBoXms8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LXBoXms8"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso5816698f8f.1
        for <rcu@vger.kernel.org>; Wed, 22 Jan 2025 08:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737564440; x=1738169240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7eNrYhn25OshZ5MoLVjVOHUVd5m0omckevSdNUfGuU=;
        b=LXBoXms8ll+P94UZjqrGmraHG229mNSssskcYxGEKKwD1/3oCdfPAmEGyw3xaxpDVR
         8MPtu3wKwY5fTZqHzSZVNaVG7hBgNm5gjbyiCr/EuZSRgzh2ekGaqYMelZEP9nr7Kvzd
         Oy4BUljhWBqu0FrzNol6r0Cg7k4zM1jtFD+uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737564440; x=1738169240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7eNrYhn25OshZ5MoLVjVOHUVd5m0omckevSdNUfGuU=;
        b=Vw6LTFLsWOxm+PReGi8yHYFzT5eVQh2FjiAtOYg5JEgWF5941O+WgHraMr4TJ9xJnU
         m88S1a6esbCiS1g9kxiaEC2Q0mg1AzHcieCDCgnR7o0dOYXYLGyp3RgIEaK8liF5flJE
         7Sc8U4xwAzpATbKDtD0U3zvEpO3KWp0zCeMzeILYB3bixN1OIdMx4cKoKI5EFexhWcuQ
         2serkzT9+O9XblH45qoHjYxf2Wn5+bhH4MZqqzIH8NH8aOtCOplG/Tq1G1Q+vsJB2PgQ
         VGugayA+8+Ho4jdAC7/vv2ttS6cyEcW9o8yljVQg4XzMc4ItYYymVFz+yGR7cksFVg6C
         eGwA==
X-Forwarded-Encrypted: i=1; AJvYcCUURnPGYg48k4A6y90Jv3uBxnYTedZNMXTzpfQpctPlZVz+MuHD9J3k73XR1xeblMpAPXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7q2vlV0ZZBKgx+TNZ+6ciqSmx73IT1EKmh6cR4noXTQ32L2zy
	90dm/Mjofi/42FDcbWndf3LJNN+Lfs06z9pDgn7Qu75605T4aSWzakr6oOhGgfi0Rbhgu+2JYZB
	MBfAbizGhHn0mxrMeqdUeWHnQSR9jLwtY7qDD9Q==
X-Gm-Gg: ASbGncsQ7SlbQRNUjKJ7T80nyurlUMoYDPe4mqudCYXcTiL5Ae9c/aMPfgGAQ0aTCVI
	viJf+i9jk7VA57kpBVyz0cklRh0PhaemZeBVViPD5heaHXQGFJc4=
X-Google-Smtp-Source: AGHT+IHJbf8ZuP6VbD9mw8MFzQIXmfmvyiLE2uMOLNmlpOLxtqeXh2VdUGTpX6n5lz5lzjHhE/ZOIe2e2J8nWACu7Ho=
X-Received: by 2002:adf:f249:0:b0:38a:4b8b:295a with SMTP id
 ffacd0b85a97d-38bf5673c40mr15605854f8f.31.1737564439560; Wed, 22 Jan 2025
 08:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z2AJCI3cIR9ETFFu@pc636> <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>
 <Z2BKLzOGv_Ki_7fj@pc636> <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
 <Z2BNWpkruY6rJv6A@pc636> <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
 <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz> <Z4-iDAONPyf7ljBU@pc636>
 <970317a9-0283-4eec-94ae-63056659d7de@suse.cz> <Z4-ruJ3KVD3PieZi@pc636>
 <7b7b92a3-780e-4db0-a5cf-3e78d79587a2@paulmck-laptop> <CAEXW_YQQii5061aNCvdCtvoBZra+5PxFWJcDCO0JWjSM3PURTQ@mail.gmail.com>
 <c210c44d-d1b1-4dc3-839d-f99ad73c3ee9@suse.cz>
In-Reply-To: <c210c44d-d1b1-4dc3-839d-f99ad73c3ee9@suse.cz>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 22 Jan 2025 11:47:05 -0500
X-Gm-Features: AWEUYZlETxKJWiDbnpK2ioAdVP_NeMgDGl1i_cppI7gm2Xv6v12c1mBpXnsjxt8
Message-ID: <CAEXW_YSm_uvuEJ5C27Rw8NRPNzhNWNg=Te3D9BVhc4ucb4tqqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
To: Vlastimil Babka <vbabka@suse.cz>
Cc: paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, RCU <rcu@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 11:43=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
[...]
> > __is_kvfree_rcu_offset() and its usage from Tiny. Granted, there is
> > the overhead of function calling, but I highly doubt that it is going
> > to be a bottleneck, considering that the __is_kvfree_rcu_offset() path
> > is a kfree slow-path.  I feel in the long run, this will also be more
> > maintainable.
> >
> > Or is there a reason other than the theoretical function call overhead
> > why this may not work?
>
> My concern was about the overhead of calculating the pointer to the objec=
t
> starting address, but it's just some arithmetics, so it should be
> negligible. So I'm prototyping this approach now. Thanks all.

Ah, that's a valid point. Looking forward to reviewing the patch and
hope it works out!

thanks,

 - Joel
