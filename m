Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600225B094
	for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179117; cv=pass; b=nyxi6ptBLeBMhYwlXM66cCgOWfMT4/4FZ+nDMaKYlBeuPRj4AbZ6oMXBLUQUIrRnmDWl47s5UBLuLXGmhMt2b9JVKUtnXlriGZ5hRDBwhzPOMNxXcI0L2w8W3kRHGjlzHmVeTiXf5DNjlbjr0kGrkf9i+r6DHcfIKuotH0hJs3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179117; c=relaxed/simple;
	bh=+BZjU+5sABFAo+aPUsrzZJGuFADNIS4wC9vOaaJtusY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF3wV9bUToUdnF7gEGHKqWMKIKkrIy10JMjflsJ44J0wEd/Zld46mAiGO1gxkzvLgwPBiFfXh4LVwdFfPvqbArYK7dsvX0Jo6R2Zf2yx6Nx3pgc1p1Qu/FAw7d/OClgdVQptUDQ0VF0dKFbbo7H/NJFYrZRTh6L75GXCyDHNxgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwiJitI5; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwiJitI5"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso8034575e9.3
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2026 08:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790179113; cv=none;
        d=google.com; s=arc-20260327;
        b=dAlxOcPmhceM5vHpLHDtj26SCIJTuOhw3MVFmOpRYsgcZxg8pQ5zv2es/I4FPtTLa6
         jc1lt2XbMU1czj6+eKlh2O3j5/O5huanQfqMzpQKBCINa9Utv/3BCDHw2e9hpOp9H3Gy
         V1+aSbv5h/KRr7nmhBpd17a+IZts3zxj0d2giS2xmbbjs5xQ4awWDsrl4QXhzvDSR4P4
         fQ1Y9O9o+Q+pO6AoP0GIxp+Q3Myd6p2vmPXbyRqUcWX8kEZLvbmVIh0Gi+wJtL69oq6W
         O3JyA+kuKOhUmcWF09/y7RX3QORMAKLq4+WE2PmdT6GOR/CEJBYgTIm3Badg48xgQm3x
         jHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K0v4coruP+L6BX4vjUSdnYrIsiFKS1VA1AwT/foYE2I=;
        fh=N3shq1Htl2lhwptPQ+NQDsSaKV/izYZVYaMgWsy4axE=;
        b=i36BDyfmwTBuAmM0N0yMP9/4v4HdNMj3ROzrn8270cOXlkl163OG4cpEAPVfpUZqkX
         tBLP119rJgJeuRS/zVEKVKa48GbNX6yrcCuZfNzYKO7i/cCO0bAwgspS6GJGQ6TqBDni
         DER+WEYKN6Z6vsdc6uIrSVOkhhrW8a4DjyTqEIkoZYFShFeJc5TOe/I1HZf2yvZwS4Xa
         ROz1BJjGbQKG4V0GAr6ABS6QFV83y+MD7b82Lev7tTQ1qIgC026NeOf7Dh0dpn4nf0J7
         L/W/VWIOhglYcpt8UAODWbi1AVHAOBIneXFdfNuYFnFvIOZozOUf3uhmZdkiapTgztnm
         WlUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790179113; x=1790783913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K0v4coruP+L6BX4vjUSdnYrIsiFKS1VA1AwT/foYE2I=;
        b=GwiJitI5ERcABqLA8malg1cUHFc0a+PfRcWxaoxerrMxh8C1YYJWaIlO9nTJo9aFsO
         qt9lLJYZf0ZWqlZQNFbZ6wTiQKB+Q958h6cOvY6llPH4tc/Cx/Ypz7AdlSLvBm4CHHwn
         WBfX0GwUTLd4vhajB9llQpD4aZTkAskn4DvHwoyv66xGv+gmSVP6Ra0qfaEhxZdPN3qp
         JF+fCvuBeJQ22HacZc6xgv8FNFYV0lxeM+dIVk+K0z77E6RUOOGUbIqxF5oursRIr4+1
         RtvH4H6e7rbzWOnqiAgHYEyxPm3SnPsP9ey9VuRqNXJrONE+tIl6k+pNuHcw8CjTYBBf
         W+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179113; x=1790783913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0v4coruP+L6BX4vjUSdnYrIsiFKS1VA1AwT/foYE2I=;
        b=AkTaBZwfXmMT89u/x/GsR+my0gRu2qBcG8NYwreERUQ1nPnzMj2g42zRxCwvM9XdEN
         0EbU397YQQyL1nlS21NmcYoZjpQmp5JMJM2of1x4OaqNQHRu0bO2p2E7I8nxAQQV8XIS
         pT5H9q3Rdf5yFmxiG4Zpl9lMSV/xEMb77b5NVRIUY1R0dYH1lZSiX7NYizYgWWTMavXw
         E0duMWTk91licr6NN3Sb83gSkh93Z49yhAM4MeWir/bcW3q7YgXb5STIthNW1AVlcbc/
         TzpJ8Nlw4MBvuD2S6qg+ZFBwzbU6FOZefmJZYi+OEZkw1mfzHcMT6pj2fR5tCmrqDmaQ
         M+QQ==
X-Forwarded-Encrypted: i=1; AKwUvBzH4I2QDYioEYFWQiPWZixd7HTFXWZaFut0AiNH+UvgodS3XvRX+nQlbN1ecPh5a6dmme4=@vger.kernel.org
X-Gm-Message-State: AFuF++lwclSM0saXy2lICKApHGsHzSCwdp7s2KeOz+3EdWHYXQb8sSZM
	ByhC7RcemtylUHB5dQs08WlR/TOuVVZ0Go5iwD7gPkbFiQQ8sEg23bjYvNj+3+JuXTn7wZVntbL
	cjBX7HpltUyQG9KgO7vjfqFdqp7SYreM=
X-Gm-Gg: AYBFou0SSvdFKUVjarteR3Inv55NVlkJzDI9tI7xyAVnedN+LT+JU4FilNlqQeEuxEK
	gcyjaK/l3GJFWQqi+gefN45a4PKXdgyyLzCRpAJIv69nrN+tYJ5p2XDMc6hoFZYbD/vDx8Le61v
	jJdYbAnh+jQo1KTDuP8ll5dHVaG1tBHeTncRxeL3VIBYxX8WUiW7sxdmKyDJsMfYqDXfeTKSg4H
	NDsCI+hOr6DFeowVwuNXJGi1iMRiyEgr7MAkvkv16qerZGfmYxCmXExCKiOSzccDCXED5a72v/T
	090hawNtP0t4lFbjJ3RxQJr9c2k+va6dLt6tjW5Ei3ygeR+OhpiRJr5PVEDcrESmkQGWgniHBl4
	UX9AhX4QSPWyXn9n7fu1RAYIf
X-Received: by 2002:a05:600c:34c1:b0:49f:bd3c:bc1f with SMTP id
 5b1f17b1804b1-49fdf14d3bamr45188315e9.26.1790179113201; Wed, 23 Sep 2026
 08:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923095435.591542-1-kunwu.chan@gmail.com> <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org>
In-Reply-To: <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 23 Sep 2026 23:58:16 +0800
X-Gm-Features: AclHuK-JmV4yqSDsdpWSQDzp1TbngEWAsztj3vbr93WLLF9_cem1MLtrY6_DvNs
Message-ID: <CAN_Opa-tDcZOEk=Mt5MAqUTkg2as5G79uBkxkUaJif8b5QpXYQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, paul@xen.org, paulmck@kernel.org, 
	kunwu.chan@linux.dev, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:05=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Wed, 2026-09-23 at 17:54 +0800, Kunwu Chan wrote:
> > Thanks, this is very helpful. I've put the results together below.
>
> That looks correct. I had my friend dig out the missing parts from runs
> I haven't posted, and do the runs it hadn't run.
>
> 128-way Ice Lake, PREEMPT_DYNAMIC production-like config:
>
>   rwlock                                   avg 0.59=C2=B5s   max  330=C2=
=B5s
>   synchronize_srcu_expedited() drain       avg 3.65=C2=B5s   max 4383=C2=
=B5s
>   synchronize_srcu_atomic(), no fastpath   avg 8.04=C2=B5s   max 6034=C2=
=B5s
>   synchronize_srcu_atomic() + fastpath     avg 3.59=C2=B5s   max  326=C2=
=B5s
>
> 192-way Granite Rapids, PREEMPT_RT production config:
>
>   rwlock                                   avg  4.4=C2=B5s   max 3854=C2=
=B5s
>   synchronize_srcu_expedited() drain       avg  8.6=C2=B5s   max  810=C2=
=B5s
>   synchronize_srcu_atomic(), no fastpath   avg 12.0=C2=B5s   max  620=C2=
=B5s
>   synchronize_srcu_atomic() + fastpath     avg  ~3=C2=B5s    max  801=C2=
=B5s
>
> The max values here are noisy and can vary by 2x per (300s) run. The
> averages are fairly clean, and I think I have per-bucket breakdowns for
> all of them if you really want to dig into it.
>
> Astute readers will note that rwlock actually wins on average on the
> "production-like" config, that the max is in the same ballpark as the
> srcu_atomic+fastpath too, and wonder why we bothered... the point is
> not just that rwlocks are the wrong thing to use for PREEMPT_RT, but
> also that all we're benchmarking in the above tables is the
> *invalidation* not the read side, which scales a *lot* better in the
> SRCU model and doesn't bounce cache lines around.

Hi David,

Thanks again to you and your friend for digging out the missing results
and running the additional measurements. I really appreciate the effort.
These real-workload results are very valuable for understanding how the
different approaches behave in a KVM workload.

The results also make the effect of the reader-free fastpath much clearer.
In the measurements on both systems, it substantially reduces the average
invalidation latency of synchronize_srcu_atomic() compared with the same
implementation without the fastpath.

You mentioned that the SRCU read side scales a lot better and avoids
cacheline bouncing. If you happen to have any existing measurements of
the reader side, such as throughput or reader-side latency, I would be
very interested in seeing them. That would be useful for understanding
the reader-side benefit you mentioned.

Of course, no need to rerun anything just for this. I was mainly
wondering whether you already had such data from the existing testing.

Thanks again for all the help. If you notice anything else in this
workload that would be interesting to look at, I'd be very happy to
dig into it.

Thanks,
Kunwu
