Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB54A4F02
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491213; cv=pass; b=KXxjMYGRejwuuEkFGdW3DLsYowZkqJQihgekCtLEba9MjrihJgQCEFxv/HG46nNI8L1wvLvYYs+2plygI9ahG1oBHDSxcQGp+dOEwBXLK2C1IoVHkOEQRw58pmdyzhM8T7FRozOdrIMAv3D446Fv88PFu04xCp9aR7DVJ5SUXQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491213; c=relaxed/simple;
	bh=8hiFmlyrGd2F3wxapBNxIaX7W5L2Ouq4sM8CP6qd4FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzycbO7PhMtWggBSUV5dC3myZrqTvmssEQWkd66nyXYAWdOBpGd/7f1m6znTcmybBeKJgtdZ52Eg4585xHKdDOEaLKxwP+sM7kIXO/lWbTNYrQ96i48VyLJ/IJG1ik+puyNa4n8uuub3Vu/yi9LlSZRgGgbdtJClvJw+s96IMEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qS+S4pGw; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS+S4pGw"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so9517866b.1
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 09:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789491210; cv=none;
        d=google.com; s=arc-20260327;
        b=Vj7SbNdhBHvvdvyXaUescLeC+5UD7jRR47eG6j35RYFYWmbyYK/k1SCktM2DCVi6Wf
         DOJPU63z9BHADfbe4rUrSGJDAieho9jG0vCLH2o8ZwlvBqhgKUbNi5pItJljTA8Ki3Yf
         7R7BqXA6tO4wOawoLtHzs8RlajGkzIF7BEbuc5gcYl1AD0+6d7JYOrVgwloorH3D+Bwe
         wzSYwjLtFw4JasVjHcOBLeRnhnd9jBp+BAJ54HSqVMiyyFfR5IGDpJpBsR9mmin+d+Fl
         SdRtio4HrJrr0e9wW0jeaqJPYCa61NRF2WgSB2Mv3YfIgKQK2nON4Jultb2B3F7KFnsZ
         rBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tdsr3ba5NiA2sUranbYpQ+z39cmPBvOyds1BGjoA95Y=;
        fh=RyKXl1fakNBmsB3y2gyyCDJaIzi5+3w+1MdtX88Z5qc=;
        b=rUplTg5E+SvNo+eMA2t3U97x60OsRD5c0BJy4R25BAS92AiY53BTJEzjRyp1Nq2GqJ
         RXckwnr06e051QxsOtB6Th0ZVIg1BnQ9/soHU+rkBiuW+ngAATHGvDMpDZ41QXLc7OXl
         VkZ8+7abhDQiJlHdPsO6+p9nLDdmTej+b/WpT1pHXmVepnTHfXI/CpyOXLgRHK0UGTjN
         sBL+CPl/kcmYOa6eoKBZtkjyLn1cHKT/9y0ni7+pcmrgtGyy7o953Zk1QU92ZKq3IHPL
         7Z6YBPQ2YF8aQCRhHu3ZT0WEMXK+AdPK5KKHQIMiPlwMjME/vdpAiAIT5EwPYVqtDgiB
         BeLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789491210; x=1790096010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tdsr3ba5NiA2sUranbYpQ+z39cmPBvOyds1BGjoA95Y=;
        b=qS+S4pGwFP3wB+HZ6Gl3LhWeyM5mqnXh79xSDZJGUUIBDmWU+U8Oh3EIHwdJ1nc7qn
         76Pp5shxs+Fl7BwH1jHxRHSKoJCv29DA2GNQtp+lG05OALQ1OAq7gkFj0W4qs2yKrGMd
         adEYRraG1M2ZlaLSWbnKH9H8Kq1245EJIg6ktKympA0Q+I2gMFHCCokRFsnuOgxgm6QX
         5NyvtbXpNMb2wBeDL1wJz+rVou4zPV309jkJyIMWgVz1ODKFdtmHCJP9Dn/FKBkuBkVO
         rTziJf9Ij40ExgRGb2NtAEMAFsBFrkfpnmAqkIKyQi9/m3XEqD2XdTwO7HOdxITOZwnk
         8rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491210; x=1790096010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tdsr3ba5NiA2sUranbYpQ+z39cmPBvOyds1BGjoA95Y=;
        b=w8Qvqnn6f2wVtbZEJvJ4bvHumpg/MV1QOl5+CfKmCQxfL9xCEb9xN2i4XI7gfJPso7
         ULpNPhTdN8EKbTo3Z9FtCiAKtiWPkqhKacsPbbwqad37iUfQDKk8uEMO9Drb/TgKySgI
         Yvt0DE/3UBycpiK03edDPcTauLf3RVjlalaTXaspuNBseM6Pp0cFxsKKt73piRHer/87
         un5gjoY+9ZNpa/A0KtiWmkdVZqt5JhZsNN+bbhWFmrFJIIvMR3vi2vS4iJSC9iMGCsD0
         JeZ7kErym4tesiAbgj7pTsMlX0rz0rLtoHa/HjEl9YzMzmSGLtbc1e6Y2xKo5ZNxZjpc
         rT/A==
X-Forwarded-Encrypted: i=1; AKwUvBxehBi0mKZksSX5AMMn59dP/lte2eKwhlhKs3TvPU1a6/9d29F6IG/dAD268yPasgaCTdo=@vger.kernel.org
X-Gm-Message-State: AFuF++mAIPC9lI9QS1dTlHTzsEstCWNPCrlTD9jPPHV8Uy9b7b2lx36Z
	Jt8N9qcwqbCKFvIv1CF8No8ArqYIDh16XpKP5Imu/PgL0HdUDTAMe7MUdtkpUq9kvLCZKv0dyKW
	BYXoTpeCdRqXvDfxf5eOxwhSioVJ9Q7g=
X-Gm-Gg: AYBFou0fpAbdih7a5UIRZbvPnsUyJFJwuTafAMhHsCwYmY6cDsdOKKwBYF/t2dBZa72
	NHylcPQDB5vPEmPd58M9hh41KUXZ59+Qt9RmxtmdlrzMfGHRQWLUTtq+dQk3PJmVPlPBf1UBNX3
	DnyS3YGIDWy6fUlwXLMl6JRf7K0F+ucfazG2gHSQvqMfmZJeWSPL83LpVz3huvar7hL3l+Pqk0L
	s+AiBqu1twvXfRQz7R7tW3LmTlAdm0qm0iUvruG1kA3tDPoFLsVCC2v7t1sU59iJXqWkVpIqw1Q
	WuZq+o60QakpxgU8jZVXcfCCQMuAn9HJ4EDq5Yg6reJekxVgN5OSgHcOKuPPbVFQgmURaTM=
X-Received: by 2002:a17:907:1c16:b0:c26:227f:5f7 with SMTP id
 a640c23a62f3a-c29b87d864fmr551357566b.46.1789491209730; Tue, 15 Sep 2026
 09:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915154248.3612028-3-puranjay@kernel.org> <a696904c51d47023b4dfabcf0a246ec9ed057a0dc8a286a21f042819b8568f05@mail.kernel.org>
In-Reply-To: <a696904c51d47023b4dfabcf0a246ec9ed057a0dc8a286a21f042819b8568f05@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 15 Sep 2026 17:53:15 +0100
X-Gm-Features: AcwNN1VwQluCIKHuel74dopkIP6TcQoG0OftwzykZL7CDUVrHXGJ_QR5XW6bc_c
Message-ID: <CANk7y0irwNsAcDWF5WAxhR-v7L_xwLj058HGUQgHd2SKFn+wcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] selftests/bpf: Add tests for bpf_call_rcu()
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	harry@kernel.org, paulmck@kernel.org, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/=
testing/selftests/bpf/prog_tests/call_rcu.c
> > new file mode 100644
> > index 0000000000000..c2d266aee8eac
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
>
> [ ... ]
>
> > +void test_call_rcu(void)
> > +{
> > +     if (test__start_subtest("run"))
> > +             test_call_rcu_run();
> > +     if (test__start_subtest("chain"))
> > +             test_call_rcu_chain();
> > +     if (test__start_subtest("two_heads"))
> > +             test_call_rcu_two_heads();
> > +     if (test__start_subtest("teardown"))
> > +             test_call_rcu_teardown();
> > +     if (test__start_subtest("hash_map"))
> > +             test_call_rcu_bad_map();
> > +     if (test__start_subtest("iter"))
> > +             test_call_rcu_iter();
> > +     if (test__start_subtest("inner_map"))
> > +             test_call_rcu_inner_map();
> > +     RUN_TESTS(call_rcu_fail);
> > +}
>
> This isn't a bug, but would renaming test_call_rcu_bad_map() to
> test_call_rcu_hash_map() (or renaming the subtest to "bad_map") keep the
> name/subtest pairing consistent?  Every other subtest string here mirrors
> its helper's suffix - "run"/test_call_rcu_run,
> "chain"/test_call_rcu_chain, "two_heads"/test_call_rcu_two_heads,
> "teardown"/test_call_rcu_teardown, "iter"/test_call_rcu_iter,
> "inner_map"/test_call_rcu_inner_map.  Only "hash_map" is paired with
> test_call_rcu_bad_map(), so grepping for a failing subtest name doesn't
> land on its implementation.

Yes, that is a typo from me. Will fix it in v5
