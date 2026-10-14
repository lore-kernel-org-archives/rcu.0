Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93E39023D
	for <rcu@vger.kernel.org>; Wed, 14 Oct 2026 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948555; cv=pass; b=s5Hzypuf8iJtBzcg542pBfKTlVKN0/G1LvGfqPdqaCqZ+J/b2CKfqXa/WKDRhxOat7NfL244NTM8+b2rEgTecSbobP593hp+nQG+b1UxcykPR5XC60Krqc6M6hn1TFpXpMaXh5PX+GFQdyutQaKMTx46TNcI4nTpS/xK86tD5Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948555; c=relaxed/simple;
	bh=y8f3NArIgEMVykQ8UPcZVmembmuVMbH9zJsVPQ/zXO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bp9Gk8B33Vyt2RnC27J2E2D/t0CHa7n92y/ls6UCEShuW8C7TFRwlaLzUBmArMtDKn+2SYOho8XPqdDQjUOSEWB4HngBa7edwBXMNTWdjrC5xLLDckoUNJE/fhvUxlzsNbUfseqXjMYXZpf9//MgEJulmc63p7wZWxMbx53nByU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9D9wcfh; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9D9wcfh"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acba4bf65eso4790785a12.1
        for <rcu@vger.kernel.org>; Tue, 13 Oct 2026 20:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791948552; cv=none;
        d=google.com; s=arc-20260327;
        b=EfWLOwZEwhb9YyBMpsXRCTI9k1ApEykXdmS4RNsLKthLHOGopolTSQ892msqJLIyaw
         3d78pPSz6hTQ5XT5aTD4Y7JzhGac/Wvd1+YxBtOgAkjNVQ5HFPbftrmipyezKRH8nv4n
         L43ERyXoiuLVbvJc0j2UrjcxDjGI1epf1a9aYqDemCIZXS7XlIyi6JPZiYRIYXjFFLrU
         pTbTiugwrMRhBkHH2XyrL1ZaBaD0w5n9W8Zapk/8fbl8or2kxWVjRmnXSn5OVJcEaRbf
         nhVQXX5OrPkWr9wtCUu9BJFWl8m+Z7goDtHFRXtA9lLkt0VMLdnd+F0fJUt7kjEJ9TW9
         i69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4KsaoaK9H/7EPqTqddbEdGkjTfIPX78T4YiSu6f0Mn0=;
        fh=ywbQii1DXr7oghEiwGxkVIEMu1H0rEC5hi9N4Grpedg=;
        b=f5qdgdUZuw2MyO2WSrTqWRmlgP3a2Q1njh8zSuO2Eeqx/GjSoedkoJDnoKrcgMbmGz
         3h/5GmfteDEXhVugwTlwsfOekxY08ueGzTsyU0CqZEWZNuQE9WDpRWORKPrLwD0C6tiQ
         xBEutZN5Q15GoxuLtMFiCfzoD2nZyTWPyfThh/JswrJE99dtDdnLqiApIVoTaWIL+oSL
         0jzvZHEOoUw1w6SZG3Qlh32qlwker3fUARt4w4AnPL8uR0p1BCjIXItgkO03t4DQQ4BJ
         IZ5beWv6X5tbhM9eYXSW75Z8frhxW6rboRW/uxxeJUtuceWvKNY07G+SUXPPIj3b2Y6n
         JWBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791948552; x=1792553352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4KsaoaK9H/7EPqTqddbEdGkjTfIPX78T4YiSu6f0Mn0=;
        b=m9D9wcfhF0gbsRXTQbkoIAZaZqIQIDZsm3R/Kb7hrGALKSqcdTnfZ08BRegEdjApjN
         MFJZYVQwzeVMLroFh5ltBP7/ypyNFOFRLF+yZepDJ4VOZmEM58KlMi1OFhFGtuZm3pZP
         GqwPfxnjGDXthvzcO7Z4Du08GImFVZAPUEelNmMJemseq5w2SoobNpxLS2YEumRh5mMs
         Q/ykb/B6gotBJaV9UXYoqVly2eNFcSv6Bf5iEhzcpKWN/eys2mcOhBxf8ugUD0RJwRMb
         fY5Cbn/xCXid3fhvAr3T9bjvWZzrcnwYacaYjkVKZbmknMqYR5VxXvXdXY7F5FaUuCyH
         ywDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791948552; x=1792553352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KsaoaK9H/7EPqTqddbEdGkjTfIPX78T4YiSu6f0Mn0=;
        b=pA6AcYAGolepv3J3rs/hsJbiWkSY3C53GinYf1KtNJR59HgvnkpcFox/ZXqVpx2dJt
         N/EJhZ1abzVvJqnPf9PZvSaazF+4jNNyAglQ6lyMdQnvbG3E4e1juKxX9XG3wkvqifAO
         svCdH5Ci4eyT/Gtl+n9S05dsvLkP+Op7imx20kMxFUbaoivnCFTYzzt1P1OtjxGys/6L
         e48mb/jHJW4ag/fA5MEm0z0eBu6LIjXnzmX8MiVD4bzPKYT1F/Hge3jGS1Y7NMX+oIpT
         yGIbntqRJ3NkakXpcfczeLjKSQ/nJ2rGVTG4cDfEGKfVfeIZ9I6ckzVRNKrRPqFeqU7W
         XOqQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5AaN1hVN7+sGpiuh67JykkPKCUatu/dtHIOhQtYy9I81Ln4MWSDWzkUqHyB8t2njcU/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtngRuRCO9rha+m3gX313ZAaqtBjqmDC4ALlxnFBOLSRQIsPp3
	FYnEznWLkAZ00QitO7A3hlhLj0CMnbO+utIaffb+FImFr5ZcD0izFT9sH9Jjt2mR+u28tWbHfUh
	bR4VvDVFr9hug1e/18OnuLhRL+djG5gA=
X-Gm-Gg: AYBFou2hMLS6S3aChOpzKFRKJbP+LZXYFgK8HinbsS7ycpqEUH22k2UdOssUvB825ky
	/lpV3qbjG0LAJZDLczUcXGfcvLso3JF2LyEZ81OKveGGlcygXVzhylsoxeVrOhz8liWlg5tKJmP
	IbiBVQcAG5w38tRDG/exeHjhlLeHTq//tPHryaPl8tarZKeMYzDgTzqLV8dEWqRbug1zQC3+mnN
	aalIjjdHLApQUfu3+qh/q2FLO+y/65Won18IYNDzAGpqGR1enfH2Bi5o1ULxveYwA02WXTrY4Yu
	KA4J84AFgM1X6n2hv1NoLrXYrcwyHDE2M4cy+1od/qJ2zIcBDEOvoGoT
X-Received: by 2002:a05:6402:448d:b0:6ac:c1fc:8a98 with SMTP id
 4fb4d7f45d1cf-6b17c28e3camr12080163a12.42.1791948551636; Tue, 13 Oct 2026
 20:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010083107.15086-1-qiang.zhang@linux.dev>
In-Reply-To: <20261010083107.15086-1-qiang.zhang@linux.dev>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 14 Oct 2026 11:28:59 +0800
X-Gm-Features: AclHuK9wwJHzzzqurxhjL6sACS69pspDCcm-93pfiE3cU9MYx9jyO3qr0weTxdo
Message-ID: <CAN_Opa86yuhp19Mafu61KbSUr6C8YGeFqG2DSfMJhzuST58B=w@mail.gmail.com>
Subject: Re: [PATCH] tools/rcu: Add new APIs to rcu-updaters.sh
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

On Sat, Oct 10, 2026 at 4:31=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> The following commit introduces some new APIs:
>
> commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
> commit '8df13f01608e ("rcu: Add full-sized polling for cond_sync_exp_full=
()")'
> commit 'd96c52fe4907 (rcu: Add polled expedited grace-period primitives)'
>
> synchronize_srcu_atomic(), cond_synchronize_rcu_expedited() and
> cond_synchronize_rcu_expedited_full().
>
> Sample output when running rcutorture:
>
> @counts[synchronize_srcu]: 48
> @counts[synchronize_rcu_expedited]: 74
> @counts[synchronize_rcu]: 102
> @counts[poll_state_synchronize_rcu_full]: 443
> @counts[call_rcu]: 2498
> @counts[synchronize_srcu_atomic]: 8717
> @counts[poll_state_synchronize_srcu]: 14849
>
> @counts[call_srcu]: 22
> @counts[synchronize_rcu]: 103
> @counts[start_poll_synchronize_rcu]: 1093
> @counts[cond_synchronize_rcu_expedited]: 5339
> @counts[cond_synchronize_rcu_expedited_full]: 5375
> @counts[synchronize_rcu_expedited]: 8134
> @counts[get_state_synchronize_rcu_full]: 17248
> @counts[get_state_synchronize_rcu]: 17266
> @counts[call_rcu]: 119168
>
> This commit therefore add thems to rcu-updaters.sh script.
>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  tools/rcu/rcu-updaters.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/rcu/rcu-updaters.sh b/tools/rcu/rcu-updaters.sh
> index 8a5df3f22550..a0f03a144f6a 100755
> --- a/tools/rcu/rcu-updaters.sh
> +++ b/tools/rcu/rcu-updaters.sh
> @@ -34,6 +34,7 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
>              kprobe:synchronize_rcu_tasks_trace,
>              kprobe:synchronize_srcu,
>              kprobe:synchronize_srcu_expedited,
> +            kprobe:synchronize_srcu_atomic,
>              kprobe:get_state_synchronize_rcu,
>              kprobe:get_state_synchronize_rcu_full,
>              kprobe:start_poll_synchronize_rcu,
> @@ -44,6 +45,8 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
>              kprobe:poll_state_synchronize_rcu_full,
>              kprobe:cond_synchronize_rcu,
>              kprobe:cond_synchronize_rcu_full,
> +            kprobe:cond_synchronize_rcu_expedited,
> +            kprobe:cond_synchronize_rcu_expedited_full,
>              kprobe:start_poll_synchronize_srcu,
>              kprobe:poll_state_synchronize_srcu,
>              kprobe:rcu_gp_init
> --
> 2.17.1
>
