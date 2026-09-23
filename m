Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B1490BEC
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180812; cv=pass; b=sTEuSQBefz6sC333CF5Wb4q6aUWgQOqMqkbIHKXE+VVyM0sl+SYDzxCWTasTcKi80ulcNzWipRFTHZx1VqjtfkezD5RRu6npncyDoKuADs7TaWF5VwfytOW+uKrJNdoHJJVxzp9oIKxzhg2Y45YgxRkHWlI1tK+n5+zod0De4jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180812; c=relaxed/simple;
	bh=nikGN8S3nY6kcpfCNAE6HAbgdnxKqm3uFGyEPxB9Fj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+XTLjpHMpEXjpw8nN1/VihPbMtyUX9CLHBfQKBiIg6V4lBq57g5iGXc6s9naXQY8QdQjE4U9peb97tT0Gs35co25jbOwMSf24U+9PEk1uwGO3kn+O087rn36HYb/y3YCDjsZBSTJMPPaw6ihO6WdLgoVpodMK/UsPEvkv0ROHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVtM0WXT; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVtM0WXT"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso7458085e9.0
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 09:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790180809; cv=none;
        d=google.com; s=arc-20260327;
        b=agp7DodsdNMywJ+Bcx9LV6k7BjUUI8RVZVwFJLkL8M0AanXkh8cV48t1ozljDu8Hmc
         QubY438qbn7ekeu3lAPs3YHcxUGSj65IJE1xPcI1p45sdSq0/sFXtSuGFDzPyCM1RNli
         SN0P/jgO8cCYiV2NoXB83qR4qh2KgUnq4xeUzR4KNTMFO5DOM9zvlTJA+ywTkQRLLZck
         imoF/S5EArBdyaR7PIfRlaaY1m5Er1exhz660dipp7tJYqejzZ65fvl9WpwczVJEmg+8
         FoALXW7qONnfeu2ar3J1wD7D+NRlH4qMCGd3FkZMivR91goU9GvMUXCyLpB8KyByS2Y0
         lUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nikGN8S3nY6kcpfCNAE6HAbgdnxKqm3uFGyEPxB9Fj4=;
        fh=jzMoHAzSNO+wllMhVwEqNLkVteII/cHBK9HCGKd+5uQ=;
        b=jQAn5YzKHF3UDFC3KtBxYKq7EYRV6xLwv/3a+CD0HLseQQooaiKSVWs/K5+e4VNajM
         dDTXkUdC4gFNCdZhKAn/Z6tyTqxr++rnA2tkXICZ07uNkpJohZ2luUBoWiMJQS5nyhxg
         7BOZVEXuM28KdS13ArY8vhU+Hy3E4SwMflfjZIv8cMmEKutgXyeHkrd/CNizDVn3LYpE
         CRhv0dH9Q5O4wRALkkyEDmd9GPtmmCFeILPPs0Y9QSx5n65pJSnBdSnLoQz9mKlOV85C
         VhX4AaYiVccfKLLYF+ZB1pVm0hzPr0mJ2sRwzTZjxPgCWIUDKKC+jlYIo0/5i8WnwLHZ
         VMTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790180809; x=1790785609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nikGN8S3nY6kcpfCNAE6HAbgdnxKqm3uFGyEPxB9Fj4=;
        b=KVtM0WXTYvLW4EAI56QD2d2oXwXIgutE1WFkbx13JgsskMlBk4Te+52MNOtq7paHrL
         1vFqQ6XrRbHucUTiPSvPOIMASzP+A8cgjFo+pRpMybfSCEmbsq4qhGENed5V3+6ry9fR
         vBOG5MHgxNHjZutlIKzzEvi9VrSfO5QwUXYZWmzrd1XrJJfNRNunYfUS4O9DdsvkwoTi
         pB60AKhF+L9FMgFev08HOOl6oZ6FlGoXroxn8peiIcDYLLZWxOrvyUK95JD03lGdQxG1
         Dz1ZqE11dve+tv1ZCh4knAlID97kXYuK/1/oq5VTvf5r7Ar66RfgIIoJuTd7kNTiIEkc
         TuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180809; x=1790785609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nikGN8S3nY6kcpfCNAE6HAbgdnxKqm3uFGyEPxB9Fj4=;
        b=krDX+bX3rHcVKUYcsKCZFo937Cys5+7ilNYYGRTvrQ20Y/0P0hgy0/uwVV/86d+6NC
         ErRXizGfi2zYMdFynzelD+Repf0HKSkNxMYe4MOyE7HZSMBuGGpTGBTnS1icktDGpRij
         NCVVcZN6iqnF9zM+1iw+58UdLnWVQbsLH4bUjotMt0BnRwZn5MBPgueGEHVdj1CXChU7
         bo7bO+E1+MD05dJicbbpAh/7cukoz5hJH+Ata3joBWRZT/upO5AmQa0cydaF6PeD84ap
         1wIOchgflgCD4CUImAvJ468oRsgBAaL5Fe89jIbzc994kk5E8Ht1I1Q4jWybZaudZe2z
         PTMw==
X-Forwarded-Encrypted: i=1; AKwUvBwrJgHkSocLvUJNqqhVQOxGfSfCpIQSfMk5FmFNt29QtSqPJtBMyeJw7eA5o3uqGBchaAY=@vger.kernel.org
X-Gm-Message-State: AFuF++lixlCIzoEQ1qRueapSPSKqtO2KaLGG9+r+gX6tymy81jpFPlaD
	V2TLdkH84Q5+0aHorffl+ayKKBhiGpGLHjQM6v7xjgUej++BsBvkGfnMk9JjFP1xccaZiVvs1ua
	b2kpNQdBAsjC00lWYsx7FaIrqQbhicIc=
X-Gm-Gg: AYBFou2z1Xjf8qhjlyi/BZMWs2KzXu9DHI5dJZFne5M1XOvW2mXRJVelzKpIBwHEQIh
	2medU4ea1raEzq+atDAN73QMcJmS/9ksh7KG0+147M7hX32IAAUXMASDp6zBNLP1IeFlu7DPsO3
	RRow5oGk8/1sf5YudALmOCdKe/oAGcFPgIdB5MV9aDLvuvmkxdfR+p13Y0Pg3kqTUoiVW3T/xTL
	0+Kp0fdVbu1fH+KopTIPTVK//RWi4+Ju0srqZnsW6tyxOSsUuFBSdFipoto/BNO//4MMi+nD4Vd
	epKAy5HgTNjQZfjbKHpn8X1GS1UYpFmYoF7r6xS4donJVkqvtxR30k68djGkKhNKCjPyHuAzUFQ
	kO+9UB/wziHYIkCXzF2Wrlhc=
X-Received: by 2002:a05:600c:4fc2:b0:49f:bd3c:bc23 with SMTP id
 5b1f17b1804b1-49fdf25367dmr45779865e9.30.1790180808596; Wed, 23 Sep 2026
 09:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923095435.591542-1-kunwu.chan@gmail.com> <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org>
 <CAN_Opa-tDcZOEk=Mt5MAqUTkg2as5G79uBkxkUaJif8b5QpXYQ@mail.gmail.com> <1cb9c1d40f246ddbe24c9fb930d6dce16aaa25a1.camel@infradead.org>
In-Reply-To: <1cb9c1d40f246ddbe24c9fb930d6dce16aaa25a1.camel@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 24 Sep 2026 00:26:32 +0800
X-Gm-Features: AclHuK_j1ltAz7PGSRQQV9EaBOqpc5nh8k8vCMKlTaWE_EVcZVCxLKzcJIFegA8
Message-ID: <CAN_Opa-xVAzFAJVU3rwCsiBzVpQYqUYWzgpBBP7EaX3K+ASk1g@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, paul@xen.org, paulmck@kernel.org, 
	kunwu.chan@linux.dev, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:07=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Wed, 2026-09-23 at 23:58 +0800, KunWu Chan wrote:
> >
> > You mentioned that the SRCU read side scales a lot better and avoids
> > cacheline bouncing. If you happen to have any existing measurements of
> > the reader side, such as throughput or reader-side latency, I would be
> > very interested in seeing them. That would be useful for understanding
> > the reader-side benefit you mentioned.
> >
> > Of course, no need to rerun anything just for this. I was mainly
> > wondering whether you already had such data from the existing testing.
>
> Most of the KVM gfn-to-pfn-cache usage is per-vCPU so doesn't get much
> parallelism. The main case is interrupt delivery to Xen guests' event
> channels, and I did some benchmarking of parallel interrupt delivery.
> I'll see if I still have those results, or tell my friend to go and
> repeat some meaningful tests.

Thanks David, that would be very helpful.

The parallel interrupt delivery case sounds particularly interesting.
Please don't go to any trouble if the old results are not available.
I really appreciate you checking, and I also appreciate your friend's
help with the measurements.

Thanks again,
Kunwu
