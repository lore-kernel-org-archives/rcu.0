Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792490799;
	b=Cg3O/RC/e4Pketmpla307+cSOb2C2IfuEyHmybtvmXk7NL/TDAfJz+6dmWPc4k65k2MT
	 nvyFsIIOfXRRbP4SL/6yULYY06u7gXNq+V4nWyCWhyqsPpxzpOwplBbP1SVA4mM1Q0cuc
	 V5M/g9+KF7vWguqy1Po9rDUr9A+hjuB8dt8cX/sfc6ftkGW0rlgA77GDselgZ2oof8vwi
	 l9J53g09hIhmkt/cjhmJV8H7AL+G1IHLGG0kb8MMwWCqi+Nu+oJcgTvMD8og8vNoowYO5
	 2R8Vap7OhL1eUw/7EfNDrmLllxujHkQb99iAAdFhee6rotTZxg9hs0Q6l74V7qwUiRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hjLEZjKc1UC8sxA1BoAn5ZhOr52xZdZQzKhwFC7bfbg=;
	b=kdG0764O55JohTOTa0huB/zadQTloCTKBLSZoY+VEsKzWdnvYF6JVdUNXla3CNqr1DCg
	 Uyd2cKm3r69jhZKICnR1gagegT+9STnf7m2yKTOZaxI4QBKpZOmmZD9bbI8QT+mx+/nKi
	 DJ/8El5XQzajSt7ocliY6UH5bewgODWn8mBfk1lR2JAckM72s3RFjSF4aH1w1Fnk9jqGP
	 7MRm8aHGBQmrcEjBq2FjLEAnXQDnWukdoVgi2aypy++el5OXvIUMLT69J4Evp1Xw2ZLRH
	 HsYFHa+7LJZ24qeTJg/jPyu/g4Dy9iCycOk7k+skR8OU4/5oohvvUT19MSe7ttQHTSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NjaRZWMn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25F606A31A
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 10:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F25F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NjaRZWMn
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c445c95d553so233092166b.1
        for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 03:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792490797; cv=none;
        d=google.com; s=arc-20260327;
        b=FsghLV1nHmSCTTHn9sweSK65BVESOrSoeUkiZOqkrGBWT1BgZmJibNkvJdJ4Glhw5w
         ozIADnIz7dmLt5A5XXHchT/MObcHC4C7/C1chVG0kNyPWh90tfH51aJyBgJzIZA7Zas9
         xzCfcD237mt2pdcQV0zv8RzpZmnuEk+VU/DRbtDku1EfzC+0TWQiMO23CLN3IdgQpYYe
         QqdCbZwaASfA5OJ2bpFT7Ald328IMUEiqTNoJiDi9qCRwm4FKJOSkosI225q3GIU5DKT
         IDKdo1onLq9Se6o10Ms43R1EvUbCILxiUkiVYP7WcT7I9iNXkV7JD8qmV4wkLUxfPx+7
         G1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hjLEZjKc1UC8sxA1BoAn5ZhOr52xZdZQzKhwFC7bfbg=;
        fh=0LnMQh4mLqW/qHpRyHskv0LSmJM4t21R5ktrWLCvCec=;
        b=WRwzKD102UgJ7ntbVHDRBnnKz/yyLh+28vX3052EyPt8pQSwIiyrS3jKHmqnRwL3cl
         a675SVO4XjYuu+TPLRDjsIwfHStJN7z/274+Hm7hwV9TpG6bhiZ4cBNaG1d+OOqiVRGn
         d7C2JuopA7WKmO6cEyUZhqhLxG4F0IBxVecS9FX0h0UaHIib550/HRq4Gk6XcrxNwrDp
         Twv1Fl4CSQS9d3+RSvYKadoiDQS6UWyvPMgysihzocaiibQFnp2TDT0fQB3N/+3rIeRL
         oimXS3UtshJdXqqb11A7ZxY/NBwmKv07jcTczZoHa9pp0GEDE2eQRwrjY+7bj030xPtz
         V0ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792490797; x=1793095597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hjLEZjKc1UC8sxA1BoAn5ZhOr52xZdZQzKhwFC7bfbg=;
        b=NjaRZWMnHZHRXt5opHR8SfpvH0Zc0PXfwbBLUNZWLc4rliMplgVX5No0JTB/4pSfxj
         8sekpr0rfnVAulU2J5TD9H0Ey8xB6EIvzcOjhGU2PonMTSnkMMAf00Toz5p8KzU4y02Y
         FvegbYJ8Vw8yOQWGHKWBJCjzUPsKneVFxnyjf5yp6NhPPOjLTRc5ETnd3BGoqY8VYI01
         t5HKl64zPFVQlQLz7g1jL/puZKh64QyPtH/TLJCMrnenPDZhGXPrTXz2rvWZIDRl//AL
         8rCvAXQm0Rt0O0Y2UvRB9WcwRL8T1HzkvZqbfyWxPhQVmN9ABLjR6h4Od8ml4NDKqGwg
         FOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792490797; x=1793095597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjLEZjKc1UC8sxA1BoAn5ZhOr52xZdZQzKhwFC7bfbg=;
        b=W8WEevkLtIqljOuu6UbImogWZ21hgiLCpZyeeMyjjPWjJDiUhNdIfxV6bqTK/BkhtI
         rlytIx/ubFyy2hflLBA0NSN8Q8GXe9KZzBVRQwoSSEEBdJ5zdwG1t6aXzYP+4CcLeST2
         nEYxednxH7n1I1w0MpWX/AaeNtYlI5Hx5Ph/K/K25ecbVNTQpjo8Ih5l/qwg1aNjfolQ
         EYqWAlehbmBbrJP7EbVSj6zgaZQnD3mjem2m1T2B+SqHZHIJ9fJLOdyGVTKMyAmrX+yj
         CnUSxcl7fnY+LdMWWSQCPLV30Rs8SqNvZd8iV8oZYyi2wlGPkX80JpEodaRx9EiGczs/
         r3Tg==
X-Forwarded-Encrypted: i=1; AKwUvBwc2Sxo2ZVN7Z9y2Zc3zY5cjCZNwHEm++vdQk4VYdf7GvZKTGxkhwNqQp5E/Mr1obpe9+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgGvMGeO4gZueNyNq/vBHXPylc1pChB5TONTn68rSn8TOdxKs0
	N3mkRYTVyWoKjAglo53/RiV+qSvG0urniEwGubGj3wAqIm5e53hUCQWab2lAgWYEMJWPwBKoPY+
	bRZW3xQ7U6pO9eb21ceQLXtg93Dl3uTU=
X-Gm-Gg: AYBFou3OtSCRSESJqZSe2psbKD/rHOqx00vIoOBNpSpyZ9a1zXvUjLGBaudQC3ry6LK
	IV/HabBcBmyAn3uVNurr+mFarVJOO7GhUaUzzmNqeYwef0tjvT8DxK1L5l1HOwGpYHRWC40Ua/i
	90tevLnUbaOi+72W94KtQXsx65GN7w+dTP3bAoxrGjqtQTviA/7nYYCO/7reHh+At49VbGUR9QJ
	XZbZcdYSSGzKo2twxlR2aGtmc9u/SgSj4ihZezFFqv6eIMcwp4UM2LHconOvZ4cQzIQV4SX9ZmK
	9y6tKssJRy6XAGQqjgj78IoL60AQqIwGb1tV+YmF+xTL84m6ChE0Ty4tCDjUn6+Zxcx7m3E=
X-Received: by 2002:a17:907:c642:20b0:c41:a5da:1511 with SMTP id
 a640c23a62f3a-c41a5da279bmr487551566b.25.1792490796791; Tue, 20 Oct 2026
 03:06:36 -0700 (PDT)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016155340.3304319-1-puranjay@kernel.org> <3225a379-a959-44b2-a2e8-02ca93759316@kernel.org>
In-Reply-To: <3225a379-a959-44b2-a2e8-02ca93759316@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 20 Oct 2026 11:06:23 +0100
X-Gm-Features: AclHuK-7_TwiedmUSuWVG98rjYO2MVoSPsgDN58DF5W8SXtLU45kxTKTy_DTVHE
Message-ID: <CANk7y0jHbggDHB_68MjZNq4h=Gu_N_G-Ytf0YLrKM_B8A=qsoA@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: Call call_rcu() directly from
 __kfree_rcu_sheaf() in any context
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-mm@kvack.org, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, RCU <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 10:23=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 10/16/26 17:53, Puranjay Mohan wrote:
> > __kfree_rcu_sheaf() can run with allow_spin =3D=3D false, e.g. from
> > kfree_rcu_nolock(), where it may interrupt call_rcu() itself on the sam=
e
> > CPU. call_rcu() was not reentrant, so commit 69abda97a09b2 ("mm/slab:
> > extend deferred free mechanism to handle rcu sheaves") added a fallback=
:
> > when !allow_spin and IRQs are disabled, the full rcu sheaf is put on a
> > per-CPU llist and submitted to call_rcu() later from irq_work.
> >
> > call_rcu() now handles this itself. When it is called with IRQs disable=
d
>
> That's great! can you reference which commit does that? I assume it will =
be
> merged in this 7.4 merge window?

It is part of the RCU pull request for 7.4:
https://lore.kernel.org/all/720d335d-17f1-48e7-b5e6-49352712cdca@paulmck-la=
ptop/

Thanks,
Puranjay
