Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72A488207
	for <rcu@vger.kernel.org>; Wed,  2 Sep 2026 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355283; cv=pass; b=Yxg5iK1SwzDIyvnVWErJR5XSqjd2AgzmjVbIuNcDXN6tmLDplA+2X0jiKRBHzyxpJBF8ea6tyycgGjKxZAR32mYxBdMCzJn6yqng7QX0cpTRvrW2BDu3wNieyinmYRxGulqOMs+ES1yoP+MlPiEW5DZG7zPaa9Jm3h5mHtyQU7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355283; c=relaxed/simple;
	bh=CX4jXXsYiq4+K/WAEmy2HAUQc54C6pP3SiHUP0fLUOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBecr+J8KkClAcC74AHGbc8VDsCCxZzLUc5T6thY6ELdL3DmBA+tXQ1y1RbxQz/zfNCgdEyxlBDaXGsNLP3kt4iNVfRdYSwSyCQdnWT8Mm5L/356NMdUaAT8e0EGDkkHH7PZOc8QRh1ZvW7dGhxorgxHYTWzhckvaRVf2fhm32I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXEvXMxX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nsZHfNwL; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXEvXMxX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nsZHfNwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788355281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WETgVeFgKR8QqwYjitWNqHJK5UZu3CUf41ydcXPg9og=;
	b=ZXEvXMxXNkO3ZYStmPgFq6r7KAP+m1IOQQlUFFYXwdNWzBRnwNu6wBIkiwELWIpuZ2SN90
	uN5NLARwpNIBwd126QqXMyAmafsghTRYXDFZlBsOPehrw/0dnyT56p3WEVqMQnAPqPl6es
	YcOSZ4TSkq+Yr6SOx6qCnnakv0rx26E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-3TdCECjsOoCUYs_HVFQG3Q-1; Wed, 02 Sep 2026 09:21:18 -0400
X-MC-Unique: 3TdCECjsOoCUYs_HVFQG3Q-1
X-Mimecast-MFC-AGG-ID: 3TdCECjsOoCUYs_HVFQG3Q_1788355277
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-39c9aa07c5eso3120621fa.0
        for <rcu@vger.kernel.org>; Wed, 02 Sep 2026 06:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788355277; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfdsA6MDHco9I2VotuhaO6/St56K9D+nl61BYQgR2k04m4uDIFqZxpdhilAdZk4h2G
         uY31CxDPL9JcjSjfLm4QddCJKFy3nheu4H7UbvKnfELr9bvHgw2ThdIzwgoXkLhs3aZp
         0Q3ihYnsTSvGhzM+KscSxT1k05SNHGiV/5cqftRz7qYnVPAER1zdN42/OyqHz/Aj64a/
         W2wgSRwX2ZST68aJ1mQuqd80GK8CgYH5EWNGh5sWV3A/Wrz0qXnI9swFKrIdTIo4xWWc
         xlXJSiv1ManSLbveoSDUqfXUHJgiIQwEMKkJPv/LcsIljeVeZHhJ7X8sharASmzYBvvp
         WkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WETgVeFgKR8QqwYjitWNqHJK5UZu3CUf41ydcXPg9og=;
        fh=VjoCRSt/5fEvAJDZ2/fgat6w1G24q5fH61Sde4u0IM0=;
        b=ccF7vSxZ20S+kmVweK+I8A1BDIeAl6yHXub5kz52C9q/0T2wtVkbpB7sQ4UoMwCo6D
         DZ8+o2iP8Yiuf+YopQT7UAxc6aj0akO0eFGEXjcn6vGi1DqsyOIVLTUoNzde/C8t620s
         xfswIIHC20jz1eqkbSMo+JKUCpZ0/ONWrN6pPgjI4/nuxzucrF0kGEPSej9dW87rQaPi
         VtCAdsRxzoEwzu+MonarbeAKh6AlTcGoV+nfoZJu1D7tOFrRBwqlnzypfR//SsY8H9jw
         dMZ4SmMtbazreskLJcAgZGglbPK6p+OeMFSpIpwLqGnpFw2QxLgyp8wZwbD1zO9t6IFW
         jJ2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788355277; x=1788960077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WETgVeFgKR8QqwYjitWNqHJK5UZu3CUf41ydcXPg9og=;
        b=nsZHfNwLW5Dm6aFE9ZDxgyXrf4NyLCV2zTy9ekQVepnCIp/hAbUvPrYgPSS5D8CJzC
         LiDzzqiiZNP4rMKHU7UmxZJB6k2/AL7AxdYDBd1vIlYJUddLAm6mDXzWRy/tWueraNa2
         jfLJXoRgsiuoy5rZ43aBWpnv572W/yoB7v8p8qu/OXPLrc4attfo/KDxwVAORqpo0hl7
         rtQqkoLzmI/Qv8gpAtPFulMmoQceYTSnFl7RB0IndJymlFgTH3iR7YumXq2s+GWpcKr+
         qH34R3ps//b1S3P6oQLb2btOSNgoXkIzeJxTs5Yuw/p/G36+wYJoHX2cWKhtDzlEocDM
         m/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355277; x=1788960077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WETgVeFgKR8QqwYjitWNqHJK5UZu3CUf41ydcXPg9og=;
        b=tIUriCwTsgYrZdqGOx9yvz6JAT4SLhKohix21ktZK9zM365sSMcW+Ycl+46ML4hfiS
         Fd5BeMGYlYCSwuXgX1sHYO506Su1TQkYD0Bint/AU8FzJE3SqDhnrm+YAV8mFjnprG0H
         3utmh1eriy0eg/rPVL1QGhAEGdBtHXydAWcSjIIQpWavHLaWqfv8THSLWDYGqZjsQoSR
         if4F2gGDRvg/reJJNC9ZFsPwe0HJRaKneKE99eBzytWugKprdF5SiU7kb7bIr1Moe/5N
         2wk8OL1kevyyBwR+OXYJHbLLSSnptiyT/kGtM8/eysfGBzw6sSYrMEQCwVeG9UTqqBmY
         8dhA==
X-Forwarded-Encrypted: i=1; AKwUvByPB3kcWu709LfjRQHzn9O19kI/v3+Cic6GD0cM7OM6hfgHZbdwqZXeIP0NYgVpeZMZlW4=@vger.kernel.org
X-Gm-Message-State: AFuF++k/99m2dYQVyc4puD1EP49u58FSmLBFmHjIILWoSkG/tKa9VGGI
	FK2yNF4mUJS+gZ00ApnSaYVVam5O8kSLUamXWu1KjCfFrQlUJi+dgU/879KHwwlYBPHzvcWtjSi
	jKypD2FpqP7hLc2SOhZYfuq5l4MBnGZ36lphQ76Ici/twgUtGNQTr7p0I7mgJqH7MSmB9ZpCNNM
	JK/Xq4W5ghezeqQRRzaESBwS7MXq0J
X-Gm-Gg: AYBFou0w5EnuUOV5K8pkil1kwcFBto9zcsd9AAKekxBhuZoN9FnCPDAXEbw0TYkj5Us
	8uzjii6eI8Pmue8q2SvQMePGKVzlOwST20vGtAxdvkaYOj+JOSsX/esrX0q8vUTIifSO0IQNraU
	jRDbVlw9djkwJcozEmxEBgz94H3cWFaOhDM3iQP1NDKpMqSWDYy8zlvAJU
X-Received: by 2002:a05:651c:41ca:b0:3a3:63a:baf8 with SMTP id 38308e7fff4ca-3a34fe23718mr11727281fa.3.1788355276762;
        Wed, 02 Sep 2026 06:21:16 -0700 (PDT)
X-Received: by 2002:a05:651c:41ca:b0:3a3:63a:baf8 with SMTP id
 38308e7fff4ca-3a34fe23718mr11727111fa.3.1788355276321; Wed, 02 Sep 2026
 06:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev>
In-Reply-To: <20260901091836.16906-1-qiang.zhang@linux.dev>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 09:21:04 -0400
X-Gm-Features: AcwNN1XQfrKRMkjAT-v4HHjnaOQ8UWFl-GmdYVXEnby5LRXI1Kj-CpyfJLPtdoA
Message-ID: <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 1, 2026 at 5:19=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wrote=
:
>
> The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> srcu protected connection and node hash tables and hand each
> element to call_srcu() for deferred freeing (connection_release()
> and midcomms_node_release()). call_srcu() is asynchronous: the
> callbacks are invoked only after an SRCU grace period, which may
> happen after the exit function has already returned.
>
> These exit functions are reached from exit_dlm() on module unload.
> Once they return, module teardown continues and the module text
> may be unloaded while call_srcu() callbacks are still pending. When
> such a callback finally runs, it executes freed module code and
> touches the static SRCU domains that are being torn down, resulting
> in a use-after-free.
>

I thought again about this and in my opinion this is not possible as
it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
handling when the module is unloaded.
I know that srcu subsystem does a lot of magic with modules init/exit
functionality to call init_srcu_struct() and cleanup_srcu_struct().
See

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ker=
nel/module/main.c?h=3Dv7.3-rc1#n2711

so this patch should be reverted. If they don't use a barrier there,
the fix should be in the SRCU subsystem, but I believe the current
SRCU implementation already handles this.

- Alex

> Add an srcu_barrier() after the call_srcu() loop in each exit function
> to wait for all outstanding callbacks of the respective SRCU domain to
> complete before returning. In dlm_midcomms_exit() the barrier is issued
> before dlm_lowcomms_exit() so that node callbacks are drained prior to
> tearing down the lower layer.
>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  fs/dlm/lowcomms.c | 1 +
>  fs/dlm/midcomms.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 2aff1c7c17de..ea8353c4638d 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -1984,4 +1984,5 @@ void dlm_lowcomms_exit(void)
>                 }
>         }
>         srcu_read_unlock(&connections_srcu, idx);
> +       srcu_barrier(&connections_srcu);
>  }
> diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
> index 8964164600d2..045431524494 100644
> --- a/fs/dlm/midcomms.c
> +++ b/fs/dlm/midcomms.c
> @@ -1178,6 +1178,7 @@ void dlm_midcomms_exit(void)
>                 }
>         }
>         srcu_read_unlock(&nodes_srcu, idx);
> +       srcu_barrier(&nodes_srcu);
>
>         dlm_lowcomms_exit();
>  }
> --
> 2.17.1
>

