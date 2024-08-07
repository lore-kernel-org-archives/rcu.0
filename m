Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78801B646
	for <rcu@vger.kernel.org>; Wed,  7 Aug 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057940; cv=none; b=VyBqEEZGvXGaPbhQPuJiuW0OcIPQUHQ7ExWOaYcQM1ngrnWm8uyW3Qze3SBZ/boN+RlYYOF4/bXjVTeUqW2F1UTmPx6NoPSGW7IQmlKX0OcCjJEgGW1hvtOQyiaSBhIp0PBi/pmFs3uw3U/QrvLOKbAuATZz8YXB1f4W5q3bfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057940; c=relaxed/simple;
	bh=2X2h9LiJJRq0WAJU7n+3LeTpaoc6WL6ZoTN7c5aELvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfvN6vTrrb9YtALhRm3vF4tCBPOYyfS2dz/NDc0Pz/gk8VwF5Z27KUgdY9pVNcJM4Y6p3f7Dqe9Ccn/a2qO6KAK0F94o2xI9nYpZ60oz/kX9ZC6GZME/Rwe5oKCTyvEGvVxg2GfziElRfMV9JYBpSg6eIF9LE4H2STKEZv/5OF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iI/SKBmj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iI/SKBmj"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so85a12.1
        for <rcu@vger.kernel.org>; Wed, 07 Aug 2024 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723057937; x=1723662737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X2h9LiJJRq0WAJU7n+3LeTpaoc6WL6ZoTN7c5aELvE=;
        b=iI/SKBmjbgrCKCOydEl8isayp22/7/WXRT3ecZu+rJoWBkwXG9AwV51xWWm/Ow27WN
         RkvgiHR0cWtu4zjwOHO6pGPzBOTR8VxtZSET/6USI8T8aUv90Gi9feBX7h0yr/b36hsI
         TUBNaG0GO9ochb8rG0JG7gMG6M8pNX5WjsAtS90M0UMLRKwYMovejzYDW37B/UcFwczb
         +sfwjUosNOHf7LwWCBONpHODSnit8/UUQIagBSPTi/wrSBu/aTF0qbR2zN3LK5in4OEN
         3pUbxMyVfnlZYer2MmeDG5jsrVSN9TVgY7mcyBBTAxeXWjYVDIcQNLDfbJD54bbKgEjF
         Nd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057937; x=1723662737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X2h9LiJJRq0WAJU7n+3LeTpaoc6WL6ZoTN7c5aELvE=;
        b=ICmXzB/jNAQFgCzPeGvTXNSBVyfxzBV62o+O+vtklXM8ZA6kEsXOzabkMeNyCRSbrm
         L+84ETSrXm4GB5upDNrafd1Hg+VxEajU67ggfv3DTriGu5s/b7JbAJLTeinEHluAvx+/
         vXNgBHC2mRouru8WXrFZpqAoxc1ESw2pUsInng3+pg2cvqh4U6XMRvdoJXP/5bsvM3Xr
         nPqNMwfqgJSYKpv6Zg5vQPDKjHdWFMDMljToKbRW5vmrX6gr/wp/nP/RpFRo2ua0lORz
         wJ5mroKNZYVB/xG6V6gazepa8nx9Vk9yn+zAaAlkCyQ3bkWFfs/1n2HCJ4Ftj/mwvsGT
         qqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB5Fvv2orYm7/NUBoAeyqH7uLeULZyowRmoTIjUf7kOdpzCKIQl/Bc3uoR4+gKoGhqlqSm/mBopl4nrSPjBkr9Mi6M
X-Gm-Message-State: AOJu0YzhKkrAye7L4ZqCsYEtH0L/5CnrLMdZqrFGKBzVYUnoKU1TuD0k
	PR8wX02uhKQFoUiBF0X74t35zsW7jQAWz0GxHZegs//vUTrSScLEdAaotPgqngndK06WvpYZOSn
	6J2PyPWptguzxCfKg/QP93IqKcASbBXf4cdbT
X-Google-Smtp-Source: AGHT+IGl+QLY/JeOk9uLTXZpix+8pBmxBKzxAVmZdPD/JP2FYHZQYL2R8eq4pkZGbizVR/lDwOnfM0bZq0HQLVUJLes=
X-Received: by 2002:a05:6402:2791:b0:5b8:ccae:a8b8 with SMTP id
 4fb4d7f45d1cf-5bbb002ac3dmr19257a12.3.1723057935560; Wed, 07 Aug 2024
 12:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <20240807-b4-slab-kfree_rcu-destroy-v2-1-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-1-ea79102f428c@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 21:11:39 +0200
Message-ID: <CAG48ez1zR6+FxGFTT5=AmzLkwVSWfBDXsSOPs3pWW96ncZz+bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mm, slab: dissolve shutdown_cache() into its caller
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> There's only one caller of shutdown_cache() so move the code into it.
> Preparatory patch for further changes, no functional change.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Jann Horn <jannh@google.com>
