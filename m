Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595DD22689C
	for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758930837; cv=none; b=qCItaYCuj1NJvn9Vz1gH5z2ic+XKQA9p5LxQmqaIY23bpw+1w3CUjUABJKBTCzvRcF5ELJPYJaXY/HcGeZZw71nPfH2VrkLN34g43LmhQGkZFh6UuJZ+xDw1J8U/jLDmIv3Ao0686DtxLVoa+/FHDqLA8PyLKW24ImcChKoaWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758930837; c=relaxed/simple;
	bh=eGOPQyhS//CpiaVSXTf4VK9njCtZlAtjX3j2YVkKjd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2+7weVmUURJZitB3uQ10CEYetc7nJDZOWxQ0f6Utxw5VBNMpma5odDmKHbhLsz1yUjgGHcKEJP0fhiWdM545hcd3tNRLC+e3+EyonwCZ/8krUs+ww46d+3E4BXdCNdfYUDWwVReRsG35T7MbLIt5QMszujaf0cSp/VuHlAC968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSDT09HF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSDT09HF"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4df3fabe9c2so2591cf.1
        for <rcu@vger.kernel.org>; Fri, 26 Sep 2025 16:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758930835; x=1759535635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTTfzN21DB87uS849xyD/v280VXLHTvOWoRCskFIjR4=;
        b=QSDT09HFQg8pzuiGra9buER5/eRom45GkDPeSMaCPlq9mI2WezbZ5W4S3HJqVSaq/g
         OC+RT/ErJsK+OsLr0AWdaCxVf9VTYaSP6dP/xtYbATrcZYbyD7zyeSCCEuEkMaQox/es
         i/1cfRnMeFyjItMDOIbfvOiGwzcVGJ2eSeGfdBctoAyi/xFcwGsrrJhFcUalevr3AxgB
         DlrUvhTgbDEaHU1v/zFm/qA9zWLux2uopxHWw1OiNvkL4OAyH5g5E6GAPheEidEESNtX
         Aqpn39QBIAbVK822G9T7n2XJOU5OAQe74qG33C2cKO638L2FUmsTGMwAoCr+6f6uWIto
         grKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758930835; x=1759535635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTTfzN21DB87uS849xyD/v280VXLHTvOWoRCskFIjR4=;
        b=JhYdbd2ZPbVI5RsyM5eVeQw4l+p97dMC+9+2iMtNPiHqMYQWClVACsZmQwI2Xtl39G
         lqUIAM6qdmiKTVIhHwqo8MYeVLIYz4jrLS8Xe9AmOq3wIIeM86lDL4KnomhJvT8GmJEb
         EZONo9vMrk2CduWEoJaFOGeq4t9jXkKsGEZXlF5ApWh/Lzzn96L70fI3WgIWAzKKHDz/
         pF+WyOyLrl1r/Ug3u9EGGE1GsaKz6XIlPWcBm7l1wqAUt3ljE9Bswg177f4o/2YPX6oD
         3laANeHtltLZWlcPcza4JIq5ZmaTLpfCZV07eCjRUYvems9zgmNwxLC+b0GTJeNGElKB
         EEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2/eqyR5u+DXGwl29PHr+QOZg8ppIEm6bPUgeUr7LRIjJ/Vd5YBbgq0Jxnp01KcWfU23I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMsIT7RmV/nXBjIJD1f2xy91J0WDx1MLXukeQfedOzdPuHa0W
	MH3ZfR7xDPXBfL9pgLKB0JDu2++ZQk/HbxlBdkiLz1oBuTpkjhX0AC+Lz11oRLm/zo8SJnB7pt9
	pY/tNTJLasmyukrabePw1J/Buk6Oy9RWH2bt6eoeu
X-Gm-Gg: ASbGnctqyGnuDBD8Fw+xiMNi/lRjjaY9LOO+BMX7OuFUJsWuPoJMTTp0R0n3TeKA9nJ
	C3KEm9q4+dWVCYlJEEVkcfYKK2tqCBissvueNbVd7BkAMw1/4QMb4Uu/8KSTYGPtD73tDzRHCjo
	3Vjc4HtQM8Cuhv6BSY+2DIiREUkl5qvhIjp7azZZkJ7gXXsSBQKx1jo8SlaiZBG8VVdsr7zmc2z
	hCM1siMdRX4
X-Google-Smtp-Source: AGHT+IG+CDxpZDq7cerRivG168/JBuGbhBn4m2N2beYMkKs8KBXjG99FU+kZal1/3nty/278PwQXV7HRqzkoe16OSKU=
X-Received: by 2002:ac8:5d88:0:b0:4d0:dff9:9518 with SMTP id
 d75a77b69052e-4dd1c1e99camr9522481cf.12.1758930834670; Fri, 26 Sep 2025
 16:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-17-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-17-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 16:53:43 -0700
X-Gm-Features: AS18NWAdMKYxmKVYaznnVjN0ZRmLOyAT5xqSY6fx4SVJ-14lr5cKqrxUTfebiPo
Message-ID: <CAJuCfpFrFn01Dx88vYaDnByRraE3qPvO4rfMaortgwYyVsybZg@mail.gmail.com>
Subject: Re: [PATCH v8 17/23] testing/radix-tree/maple: Hack around kfree_rcu
 not existing
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>
> liburcu doesn't have kfree_rcu (or anything similar). Despite that, we
> can hack around it in a trivial fashion, by adding a wrapper.
>
> The wrapper only works for maple_nodes because we cannot get the
> kmem_cache pointer any other way in the test code.
>
> Link: https://lore.kernel.org/all/20250812162124.59417-1-pfalcato@suse.de=
/
> Suggested-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

With one nit below:

> ---
>  tools/testing/shared/maple-shared.h | 11 +++++++++++
>  tools/testing/shared/maple-shim.c   |  6 ++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/m=
aple-shared.h
> index dc4d30f3860b9bd23b4177c7d7926ac686887815..2a1e9a8594a2834326cd93747=
38b2a2c7c3f9f7c 100644
> --- a/tools/testing/shared/maple-shared.h
> +++ b/tools/testing/shared/maple-shared.h
> @@ -10,4 +10,15 @@
>  #include <time.h>
>  #include "linux/init.h"
>
> +void maple_rcu_cb(struct rcu_head *head);
> +#define rcu_cb         maple_rcu_cb
> +
> +#define kfree_rcu(_struct, _memb)              \
> +do {                                            \
> +    typeof(_struct) _p_struct =3D (_struct);      \

Maybe add an assertion that (typeof(_struct) =3D=3D typeof(struct
maple_node)) to make sure kfree_rcu() is not used for anything else in
the tests?

> +                                                \
> +    call_rcu(&((_p_struct)->_memb), rcu_cb);    \
> +} while(0);
> +
> +
>  #endif /* __MAPLE_SHARED_H__ */
> diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/map=
le-shim.c
> index 9d7b743415660305416e972fa75b56824211b0eb..16252ee616c0489c80490ff25=
b8d255427bf9fdc 100644
> --- a/tools/testing/shared/maple-shim.c
> +++ b/tools/testing/shared/maple-shim.c
> @@ -6,3 +6,9 @@
>  #include <linux/slab.h>
>
>  #include "../../../lib/maple_tree.c"
> +
> +void maple_rcu_cb(struct rcu_head *head) {
> +       struct maple_node *node =3D container_of(head, struct maple_node,=
 rcu);
> +
> +       kmem_cache_free(maple_node_cache, node);
> +}
>
> --
> 2.51.0
>
