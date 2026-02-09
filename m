Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929E238159
	for <rcu@vger.kernel.org>; Mon,  9 Feb 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633684; cv=none; b=TV+/osr/cct/i1xOKpOTKthCbg4tYluBCJeV3IC6paB7WP8W29mQN3flwsMLnKIOVZKENkVKTnzNFzyE3kSyBwltF2SLyEaIv0e+Ivk2vieknP+SN3ywtRRAiVr1YfaG+QYfRbNFMXuvXs/N5f4VstteJfUVVK9AYoct8+ei5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633684; c=relaxed/simple;
	bh=64SnTDVjxPBO8/D1WSbXynmYKOC747zxXu2M/2TsRic=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwTfxQ3RNQYZMbIBhgOs/zBKnnK+PeahjDbItxNeZKtfIOVAGQ8i5G8yB6I3BiRwTNr+G95oVi5MAb9za/3LGpwzOwRt5goRTsp4K8tdpxWYZplabWaCQLq6FeQZUZZqkkPdzhdJ7boLuv85Mhmo//27Y0Q7K0KIcr3IG9FaMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJrFntQY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJrFntQY"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-382fa66fa9dso31263111fa.0
        for <rcu@vger.kernel.org>; Mon, 09 Feb 2026 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633682; x=1771238482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vceECY6oOVlxttD05QrM0v69VFRLzzkozbTpsthX2I=;
        b=lJrFntQY6ghDt64qSZ2RZjrmOnxvAvV4aM5478alnuXcPzddm4iBNBviYzAVuPWxdJ
         RP4Hup+LhyTxS7QhN7J2xBKlsIKE6JHcqSc2VuzFY1t5S7mtUAEuq+EyN6yA3SsC/ZVH
         gAmi9ffanskRfoAqy+PSUg1njaJJ8hrkfh7rBB7CHaxTvRddvxak7rZgDSE38F1G6eLU
         xzK+zyrV09wIx8Wl/FfAipGy1IdeBBPqOpmVxrR+QiE2MXwTndFDciPGueNo99R0nmie
         PLdT72Zo7M91gKqetMhjed3IzqIYy+WwtjcYdLZ5RkotUimKt5KzZLlUI57fuOGfYELX
         Zb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633682; x=1771238482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vceECY6oOVlxttD05QrM0v69VFRLzzkozbTpsthX2I=;
        b=w2OEmVdbUNZB4+JzFft8IEKQiMhKnx/V/cUiqz2PB3YAr0W7hRHVMAGDW/7m0VRwwT
         wQ4YW3lWLYLC5Wi0736sxwLEFqfjEufnwPHA8mrKsZ+a2j7bFsJdkDFlrqYH1OAMA8cI
         pWeYvrlDBLV+OkAO1NhJ5GGbjOCrQpOyDwjlKUfJL/w2PdplbusmO01rOuwBPfk/z6Up
         yNjJiS1t0pKTW/U05DQr+Zk1L/lxP3+0XrAjtPkLaox0iEPswJ5SwkcD+ZaqAnRY7jrF
         xlaR3p+M5a4DQl/wYsnqsIiaejzAUyY/BIdx+e08PpsKxlD93pUBSUt5uprzm48fhWIn
         LuKA==
X-Forwarded-Encrypted: i=1; AJvYcCVdwiqL/Ma36XM1665OWZrG30K8gOXB64rvI2ZgLsFG6STTw0Y81ceCW47aQ9kFpdTgcdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBvA0l2bhK1QL2U5Y6arU1upbzb2QtRXbuIgyRtR3p5LU1PPD
	3+Y63/8csPhmj9KVn23liHPExwubuI29oQo4uLttJq8QHb8d3U66zCrb
X-Gm-Gg: AZuq6aKoVyTr9JezPAnfrh+x0owyLNyuHZE5+Yk7Dd62FUONJi/ocYGDWbhZBYlVZ2u
	2Oy9uioftam+4rBwMCegGS2N7ssu3cpoismB2xsfvtk2fPXw3Bmoht6mQ4bJH0pgJQf187uyKRO
	nDVaEziSyTVbt4OSoBruBq0zjSS45IRGUjBA5t46b95CELmX9hHnTrPv9hJnyMzVrI8MqJcyZZr
	9LeVhtj4fnCQ2tV4QDFb2ic9csbU+ecrgW6XS7NOOhthV7Q9GlDbaT8vHmSU/qp2S1hzOkuUC1q
	dkJeIiiiUaVfCAKPJYv8Oxe9q/n6Wgc4MceJxpQGeUfkpj1ejj27GSi5s3IpVzXdomvb5NUj2jT
	5x0ZVjqNVJKzlBt66ciqaXKxJ6FgebjDyyQ2UiNcobdco1VsuQAWndmTxtfUx0linS9xiOBR7qf
	KEmXpDM5cZvV6jku0EmN1qtE01J+bH+70RjcqKGC4f
X-Received: by 2002:a2e:a5c2:0:b0:382:56ff:5207 with SMTP id 38308e7fff4ca-386b515ab20mr35812111fa.36.1770633681964;
        Mon, 09 Feb 2026 02:41:21 -0800 (PST)
Received: from pc636 (host-90-233-206-112.mobileonline.telia.com. [90.233.206.112])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b6281ee1sm26940621fa.20.2026.02.09.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:41:21 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 9 Feb 2026 11:41:17 +0100
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] mm: use rcu_ptr instead of rcu_head
Message-ID: <aYm5zZLvkZpCYw2s@pc636>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <20260206093410.160622-3-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206093410.160622-3-harry.yoo@oracle.com>

On Fri, Feb 06, 2026 at 06:34:05PM +0900, Harry Yoo wrote:
> When slab objects are freed with kfree_rcu() and not call_rcu(),
> using struct rcu_head (16 bytes on 64-bit) is unnecessary and
> struct rcu_ptr (8 bytes on 64-bit) is enough. Save one pointer
> per slab object by using struct rcu_ptr.
> 
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/list_lru.h | 2 +-
>  include/linux/shrinker.h | 2 +-
>  mm/vmalloc.c             | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index fe739d35a864..c79bccb7dafa 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -37,7 +37,7 @@ struct list_lru_one {
>  };
>  
>  struct list_lru_memcg {
> -	struct rcu_head		rcu;
> +	struct rcu_ptr		rcu;
>  	/* array of per cgroup per node lists, indexed by node id */
>  	struct list_lru_one	node[];
>  };
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 1a00be90d93a..bad20de2803a 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -19,7 +19,7 @@ struct shrinker_info_unit {
>  };
>  
>  struct shrinker_info {
> -	struct rcu_head rcu;
> +	struct rcu_ptr rcu;
>  	int map_nr_max;
>  	struct shrinker_info_unit *unit[];
>  };
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 41dd01e8430c..89c781dcab58 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2596,7 +2596,7 @@ struct vmap_block {
>  	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
>  	unsigned long dirty_min, dirty_max; /*< dirty range */
>  	struct list_head free_list;
> -	struct rcu_head rcu_head;
> +	struct rcu_ptr rcu;
>  	struct list_head purge;
>  	unsigned int cpu;
>  };
>
Why this change is needed?

If you want to save 8 bytes of vmap_block structure, then i
do not see a big gain here. We do not have so many vmap_block
objects.

Am i missing something here? :)

--
Uladzislau Rezki
