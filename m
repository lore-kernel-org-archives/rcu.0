Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437664078FF
	for <rcu@vger.kernel.org>; Wed, 14 Oct 2026 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950323; cv=pass; b=nC6cGOwGd+xO/6jpaz8A26B1nHUJrQuH0xgtVaghGwEqtLWIkulWVJaGCsu+FULKxuqltTWC6FcyLnYZhyF2hSE4L9ZSNwIH5sZd44ejuJtQmDrrAFk3KzjvfLXWkSbkL49OFCi9nyS86mNggPHSuO3Vk4QWlALiPGTc3lrx2zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950323; c=relaxed/simple;
	bh=WorismvNRkuQ9tjYVreeBhmYfh3bupSga23jA+9gRoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/1lDXyBcJU0C1PPScH/xj5ZP8xEEAqNnNG5qgPLqLyL4jdXYfBBtbtnRl+5UXcUmxOqF7tG82oP38DLnIJmQSMpVKZEKK+4GWV0x1Fz2kRY7a8R95O7h9jH5USCeMH0NWt/7WZ2Q3SPRMA0K3JuWbel6Y7I/klpf+Evc58bqbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YE61nxA4; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YE61nxA4"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20ce3c118aso513437066b.0
        for <rcu@vger.kernel.org>; Tue, 13 Oct 2026 20:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791950319; cv=none;
        d=google.com; s=arc-20260327;
        b=PFsDQEtpiDyREPo0KV739wq2bLosOR7ZC3q9UUyaSR4jSxJj/6Viw6++7/dG+7ORG6
         aX4xxDx0J4rcYLtkwLnbWF1a+FGhrlHM4+fdjaW8SNIsM9J2JuhPsi4nZsdO+CKqDkd+
         ORtYb2BOYO9PUx5gyhrGpAF6IwPuk1kUpe5IAzpODeQO4WcTbUiJPyMbiJ82ZyvrPjjF
         m2uSIOMdoDdacKVh1G+K2VxJYawS9OBMzcBPUjX7p6WZf2pBjsVu6CLUbcIMFsLBdVqB
         YnpEZlZOP0x8oUWCiRTp9Ku0L1baPZyWEwII8fd050sSu7EyS/VCi1fZsRZr3PM+3qVL
         lKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hCM/rLbUxNjORiVZD5L+LGA24mSGgi/XAzABcfZnU2E=;
        fh=Uga5vQBbQAVLVgZM+r8P6PIMiqp4uGLFWc9AMgRZtio=;
        b=cHSnMShED5EgfEiIDyyNfY4FSgSuddgWS/zDK57xygkTM335DasetmlS2oTmQtMtRy
         wU8k3FNlfs/nk0A/vDPpeb991QbJjd6N/Y5jk7p+ktHsjykgwotGT5mtp5EauHFQLXmm
         vbmeU3bcDZUfQOcUQZIGaEc5NaWy9qh9dUBn7mgcN2v5NLv3B483S4gEr4TXlGgZkJ7h
         T44lZDqKg7favLogEBbi+J5kYjhdS0jsb3+xSEJNddfz6PciGXm8KscKP29y/8d08Zmr
         LkUBVNKR13APDZ4ZMF3VJdrXbAc1r9sO4/4rEjz/bVqaS5kAKqmjiaxJpYtehBrvOKnk
         KnBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791950319; x=1792555119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hCM/rLbUxNjORiVZD5L+LGA24mSGgi/XAzABcfZnU2E=;
        b=YE61nxA4KCGgfRRmGze17+5Jha6T3v9A+xiW2P+24Xl3ATA/OFi4W17EadZB1/wEeb
         16msuEdw50/r0+A12SJxhVCLTzxPYdn3Ur5ASIy+tSpZDI9pfhknLITyCBL2lgh4AQzu
         GOwnd9XFvZNuZItJ2iNgbrpoHhJDohDK7XrEfraRcZmDweK2727iqSntxq84DUXCzxr/
         NsHOTrxKklKR1l15VnVrkoeZDZVcU8SRWEbcYvkauEkt+K36sMZevPk2tYheY4D8wo7U
         vmz5TamaHH4ybTiTJpZR6w07zzLpTvfMvdK/MsGUDqYUWjg9iuqawd1JuTNxQKSuHbSs
         vang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791950319; x=1792555119;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hCM/rLbUxNjORiVZD5L+LGA24mSGgi/XAzABcfZnU2E=;
        b=ELf08gVj2soy45kbRfOios37mwL6ldIKgKXnbFBD+D6674wFIqQoFyZSnO4CK2w2nh
         2/a4+n7lKQPnn1nkNuxobSxOW3IDnIzxxOJ6U1YKZvOQK4a+hl9fz5374v9wvA24rY+0
         R/BhW2je4SWA7lu/N+ThACzIokzJEeIt6cccyspQkc8bPqi4HBEm8ELHTW46hD2ivN3/
         rTOkqWMoep5P6GZgSB/3P10eA2nRJ4AttVA+l/esIlatkgXqslmh02Bd4nZf/0CY22MC
         bqPp/5hC1aQ5+If1PhnZUUVzOPciL4Oqv1pZt7642fwUQ2uZJYJRffca3xePkq4U5cWb
         MDqw==
X-Forwarded-Encrypted: i=1; AKwUvBy39Tl1NOA0C5y3sQlFLFT8S0b+4bGm9nOWPz1KcVEfgEYBoQTHPG0aRLbLOj9BKpzxmr0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFmDJ3X+Iw0I9Vfto7QYcOQKfJNJIJvdkVkY/6zWH1qQlsZS/9
	GwLNBKyBgmZoWDK9UfF9/Grmkbq9AcS/w6JeLd8m1wBH0V5wCzi2eK3xP/zkqdzLfX5Td+c6g/9
	J31chdOc7EBDhAsnt69Iz3vm28lvm3FxyKDTpA5NttQ==
X-Gm-Gg: AYBFou0yApgQqgqvUjADdBeFaI7Pp7dmnvIh3H7cpD6jHV2naYiKRmMViYdCJDbxvaz
	cXB3rNLKlTHDUiey1hGhTGevw2z9oSOKumCdwcs5IhR7rTKdroAyT1nInAE7ORD3VNirMleqs5S
	w224j1citkQo/j7qqHRqg3tEsHK7lsLf5lMXz3P7qJgl3nnGz67GKLiq+/Q0mskdbEACjIyGFqs
	SrDq2BnpoAr0LiysZXIu7mSPIL107nyRfJYZsgouoB3B4HGqszLPQn19SQaFnIDVWVKo1jSW22c
	f3zBGX5KeNqPR4QvYJuZivE9r99lBblLZHQSAcHPNIBLBmmoU1qOSluDx63+vXHNm349c5DxCAZ
	Z/f1bWeDG
X-Received: by 2002:a17:907:9813:b0:c2e:22f7:59c5 with SMTP id
 a640c23a62f3a-c31a700713fmr1462632366b.7.1791950319528; Tue, 13 Oct 2026
 20:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
 <20261012205447.2717801-4-max.kellermann@ionos.com> <a64f6a98-de70-4004-aac0-312cb05aaf92@linux.dev>
In-Reply-To: <a64f6a98-de70-4004-aac0-312cb05aaf92@linux.dev>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 14 Oct 2026 05:58:28 +0200
X-Gm-Features: AclHuK-EVXCJZ2dMETv7V581o_s9NhAvmGhqI1-eNh0gIrQGd2lTR1oPmoD0xNc
Message-ID: <CAKPOu+83bH2CRtiAio+1VTTQrYFF9th5XfG5wL45ujEavPS3Dg@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
To: Ridong Chen <ridong.chen@linux.dev>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
	baolin.wang@linux.alibaba.com, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:31=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
> I've also submitted an RFC patch that addresses this issue.

Oh, interesting!  I did not know but your patch, but it looks very
similar to mine (but without the hlist_nulls refactoring so yours
comes with some code duplicating the hlist_nulls header).

Too bad your RFC went nowhere, that would have saved us from a
production incident...  Anyway, even if neither gets merged, I'll keep
my patches on our internal kernel fork, because they do help a lot
with our workload.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
