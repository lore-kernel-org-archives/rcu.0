Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781448EC68
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474170; cv=pass; b=ue31hV9dWjjykc54d1hdm23vhSVkXEKHjocvZurpd6YK8fxLcNAJJmfI/P8UcdVvRi1SLwvah60MVdb9svTDKcfab0fnjO+pke2he/cKarwue3dEebs9QqT3JPqBvPZpimt9rz0gvBiao3uO6v2nyl0/THbmFq5lVRNHSrgQLto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474170; c=relaxed/simple;
	bh=ypAz52v+DlxP5pSf3Vg/BgjrF4BPORw3LjQw7BsEmco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptQ/oUIwN5H3MC6R485uPpDhQRMsH3gAT2KQ+LiEY/W4Rfb1nXDsLYWMn34EaP/3oHPWB8AFq66vV90gfykQud4Q8JE7FDMHNaZMqoFgigEQE8q6RP0HZ3N/+KSaB95Y04O7tK7GWltiS40nvtEOcwCmdz2cGNggQMvSma8rmfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1vpNKvo; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1vpNKvo"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d33431c8so34415866b.2
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 05:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789474167; cv=none;
        d=google.com; s=arc-20260327;
        b=MnfoxWLa0LO0ZqbAWAv1CH77wPAgp3hQV91kpaBbpxRz2bAh2PV73dg92Y8LTz/jU0
         q2Y6D17zMLhJ2BJFkiZm0qC7hbKT/01JDvqKqli5I55MF6rV+xviGGFXyHDNuoFrcruk
         JmBz3Qdn5e2DIifaFs2jpB2hk0DtDVjXF8gd+s1Htnl1JlJoeXexeSgza3tqMLAsi4QC
         1r5xs+2L7pl6Ew9vL2FbYHj2GfwwCQMqXCX215g/raOGnyTgsP2gDKIbzZe1oWkJTDBB
         c/O/Tr5y7hb6nFojiuOjAyqspdYV4kG7qshqoa0jwlhleVmsW1lXzuGW0sV9EGRAZzrS
         huZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GFhmdtp0y8oWGpHMp4iKKgSXGEeI4Ce+whtx2PLrXEo=;
        fh=6BonqNVz9beWk7HQrQnBQy+2jBpJITfLmxMaahO8Nuo=;
        b=IUeJSXuw/rdXt2zJ+5Dd76py9b5YyxmmxcIF48So/OZzyb664m0iKKMRlq8P6X2tT2
         PIKkPcICilIoamyZIoecEsJUh/DWSYlciL4TpE0KydfgiG9UKiB9PRHpy6O66NS1oUSc
         M8H8cCP2MS+bVnoNUGbOW9ugUP2iITmzt0/Banq76P4bXxj2uVUlBJRUJzgYYgqDo/Kh
         W9iEXfzEX8PbADEIuBTpL03QuoKIXMINktqq/VLgBl/hDZTA1hee7VJhSruPojHX8Gfd
         kQFyxrG587+T4a2ExzdzNWJcYMtGrAuselb+Zozh0ShU9wFu86NRTlxETjt1rMQ9gWxm
         lGDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789474167; x=1790078967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GFhmdtp0y8oWGpHMp4iKKgSXGEeI4Ce+whtx2PLrXEo=;
        b=Z1vpNKvopybZ3AB/rKwP57+1ZAdifwQndZR6Shr4InOrv5X9Rnl5LTpfvvm/+XYyxA
         Wt6yw9gEBErm2J3AYUHoi1hrzTj/Qw29NdRTSijSbcI1dxeLyFkfLZjLk0SfKKAMNhZJ
         5xN6aWXaT/ZwYPWdaYufdURmeNFI/1SE20AwuBbBsaFwmsKdXs4rkthryOFXASmPJN+p
         XXuAYrSIFXS9gnl6W2wl6PYfr3rDd4LAWAF3mab/6YpwH3dnbD9Ib5fl16xEEFWTUuM5
         d1ey2NZtVKru9+VdGYEeQDiEB0QAwn0DmDVRmHR+l7uycqB9S+2AP0ej4JT3lXcvRyDz
         JXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789474167; x=1790078967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFhmdtp0y8oWGpHMp4iKKgSXGEeI4Ce+whtx2PLrXEo=;
        b=uhdR0s23RIPSUHhKZSKZRrbNVmkRMjyGnpRX8mMc6Qp/n3/laIiV1wMKY9tKO/WK0q
         i70a/Rnrie7anklgWKiqQn+jQCKcyx5NB87ZghEIMfcOM3EysRH5Rb1bGdGQMD2Gh762
         6c4ULcfFKhqKU64tzrairr+Wvf5YiEiR9cGSCdQdPGg9RSpRAId4nIKq2zz96eMVGHNo
         jueG+Qj9RX5tMP9qQBpEquIYG/DHlTEUddD9y8jCbCdg95YFNJ2lC6KLRoHlO7079JiO
         OKlhwP/tKihTnlH98l9krbdZgwK+CSYjBIwIuy6Ky78Pf6myNCz2ObOnxnMyeXEDjn10
         sWVQ==
X-Forwarded-Encrypted: i=1; AKwUvByu/t+HUVOJjTJI9SNxFxOwGb6WgGQMIPW/4HOsoR+d3JfMXeaLauKe/2IuqpFLyzfZCDg=@vger.kernel.org
X-Gm-Message-State: AFuF++l6mj+nisXWo0Ey+jya21ODD4oMcZEodDmofg0BAWJOVjhsAnbF
	xxhvB5bzbMLnuoueLyVXAp9MlFQOYhDO4MPcnOQyDohuQy/SY6JUdapu9zCGyarPHPbzIp7kheT
	avF3sQpvSf9zgwkEHsYuOXVQc4Selcss=
X-Gm-Gg: AYBFou3CcCUrOt1kIVYEzF5Gd062sES8O8QRA12rmhqyTYcsY5BOn1wSrc3322SpPxm
	68yFLra0S32uVumVWCR3Z73a5ZELcAM+LmFySk2ma9nbYWQF7RlpwsILoG5W46dDaHeFbANeTWy
	XPtpY7SspwUfeRNBtGVF6vB1qLPVEOn3BshGAHkBSdEIAgVedmoVpswQUz9hTDIrpKCGDO2C/xW
	09DLYRietjnAVAQEI0NG8rAwAn+ev6aOQS2MW1IBGn7vbq5C7QJi8UabJgXBDTkpD9D2UsBd2mG
	mV9VIlL+HtHthDfL+wQ6DCsl4jRAkD2yBdJhnbK8Ycow5eJ49t8YkPev654qWWFdvnlkioLcZDk
	wiTa2dg==
X-Received: by 2002:a17:907:9702:b0:c26:19e3:e982 with SMTP id
 a640c23a62f3a-c29d7940434mr70757666b.34.1789474166688; Tue, 15 Sep 2026
 05:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915114240.3269184-1-puranjay@kernel.org>
In-Reply-To: <20260915114240.3269184-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 15 Sep 2026 13:09:12 +0100
X-Gm-Features: AcwNN1WBijSOB0Z6HKZtv67-TIpiQyVOtvn_TsLwI0T__Qd2bkJzgy3c0fwrmaU
Message-ID: <CANk7y0hMd7ja7SK9Lqaq2S4_DM-GTResT_B0KV7WYy3pryvJZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] bpf: Add bpf_call_rcu() and bpf_call_rcu_tasks_trace()
To: bpf@vger.kernel.org, rcu@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this version, it has build failures. WIll send an
updated v3 patchset.

On Tue, Sep 15, 2026 at 12:43=E2=80=AFPM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> Changelog:
> v1: https://lore.kernel.org/all/20260907134552.1772405-1-puranjay@kernel.=
org/
> Changes in v2:
> - Rebase on bpf-next/master
> - Use rcu_read_lock_dont_migrate() over open coding (Alexei)
> - Improve re-arming selftest to detect failure (Sashiko)
>
> BPF programs that manage their own objects have no way to run their own
> logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> free, but returning an index to an allocator or unpinning a resource
> once readers are done has no equivalent.  sched_ext's BPF library works
> around this today by pushing freed nodes onto a list and having a
> userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> BPF program to reclaim them; it is the first intended user.
>
> Add:
>
>         int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
>                          int (*callback)(struct bpf_map *map, void *key,
>                                          void *value));
>
> and bpf_call_rcu_tasks_trace(), same signature, which also waits for
> sleepable programs.
>
> @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> callback runs as callback(map, key, value) for the element it lives in
> and needs no cookie.  The field is only accepted in BPF_MAP_TYPE_ARRAY,
> and arming holds a reference on the calling program until the callback
> has run.  Patch 1 covers the lifetime rules.
>
> This needs
>
>   https://lore.kernel.org/all/20260810122758.183765-1-puranjay@kernel.org=
/
>
> for call_rcu() and call_srcu() to be safe from the contexts a BPF
> program can be called in.
>
> Puranjay Mohan (4):
>   bpf: Add bpf_call_rcu() kfunc
>   selftests/bpf: Add tests for bpf_call_rcu()
>   bpf: Add bpf_call_rcu_tasks_trace() kfunc
>   selftests/bpf: Add a test for bpf_call_rcu_tasks_trace()
>
>  include/linux/bpf.h                           |  10 +
>  include/uapi/linux/bpf.h                      |   4 +
>  kernel/bpf/btf.c                              |   7 +
>  kernel/bpf/helpers.c                          | 102 +++++++++
>  kernel/bpf/map_in_map.c                       |   4 +
>  kernel/bpf/map_iter.c                         |   6 +
>  kernel/bpf/syscall.c                          |  11 +-
>  kernel/bpf/verifier.c                         |  84 ++++++-
>  tools/include/uapi/linux/bpf.h                |   4 +
>  .../selftests/bpf/prog_tests/call_rcu.c       | 216 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/call_rcu.c  |  89 ++++++++
>  .../selftests/bpf/progs/call_rcu_fail.c       | 114 +++++++++
>  12 files changed, 648 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/call_rcu.c
>  create mode 100644 tools/testing/selftests/bpf/progs/call_rcu.c
>  create mode 100644 tools/testing/selftests/bpf/progs/call_rcu_fail.c
>
>
> base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
> --
> 2.53.0-Meta
>
