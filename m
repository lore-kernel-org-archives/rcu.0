Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E26306B1B
	for <rcu@vger.kernel.org>; Tue,  2 Dec 2025 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665317; cv=none; b=rdglBvdzlYkiyuT6vmlij/TOSUHyi0cxAMpb9qqtp1N5ILi/kL63BphGRaAm58fx24lSdW2vUyDEVlFz6v1vGgni9GYgJIPv2DvTZ6nsi+D6RVJS519+GZzPqX9TS/Esjpf+2VoicSF3ghV8u7O+PBohZS54G/h14UGP4An9Hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665317; c=relaxed/simple;
	bh=RQaKqQm9FHtUQg9iabofaQA0brFzM9Skzz+R/aRupC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZy6EvOFKmv7BQTrSJrcng2W/I2CNGbZOUndIrTARPevmCAebvpVppkC04CiU05UlUa4/aZJY7aXizWPzgaV6nDgPFUoVMp+i9iS1AGrYop0tEzbY5a2yp1HrYq4/NRkbxS7OXYzTOYhOgjTv9vOe6GIThwm8oKFIs2in67D44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHFqOHlS; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHFqOHlS"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so4644124b3a.3
        for <rcu@vger.kernel.org>; Tue, 02 Dec 2025 00:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764665311; x=1765270111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:mutt-fcc
         :mutt-references:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBS8+olM/4M+ACTFgRPt5Ss6w8SxO0WWkLSTJ+Iinlg=;
        b=NHFqOHlS353vsjiCBruJOm+OaeS7noU0ux8+I+8/EiHV9R4QBEwMzjmQcsFxXYugkv
         kEJ8J//RA/06jNNd7uhlhggs8aAkdqiKCylk/FAwOJktiYohkIiWFVdj9Z+jxOljnSTX
         9RAFMtCh8idLT2oWNViE7LwuxOB6dtW+WUewhPnafzJcf+0HnOuzXSreHa7KKWtG/rsZ
         bXpDppNXUQkBjMBIgMx9eRM+JBvy0uD6UYrNvWnVglqHVlQsbFjcNbxlgAjojO64hNxr
         IsRpxcmmAYkG2hvLro0pOfC+vBZcurJ3PyjfaGE/1HqacvQzce4J7iJf9/379fezf+8X
         s2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764665311; x=1765270111;
        h=in-reply-to:content-disposition:mime-version:references:mutt-fcc
         :mutt-references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBS8+olM/4M+ACTFgRPt5Ss6w8SxO0WWkLSTJ+Iinlg=;
        b=cRssFCESeupwO1CwFO/ABbkax4nXLbAssDZ8VseTYiykUCCA5OWP79KNM8qT77I4Ip
         9xkfNN4AX8J7hGxDCY7ieFIMX6Q8JwHYuNm60zOHP4ktQ4hzBnhdqkaWlBJfOfXOOdz2
         ZlhUE2VwXwluZ66Azvm+ArQ+a9xKrAIhb3b37SeHp6b/QznFuFTjRSGfU0ZoUBcFmLsC
         kie4zxEP/hFTZeWSXX+GjXjm1nTOzqlz6icB3J8z6dRanycV6f6YleX2VllJIjegOUob
         zTvnnCL/RQH9I/KdQkZwPqTYGQnDM9YYNIGMzCq8OomnTpW1F9LuXaH3dzg1/qCYb987
         6BLg==
X-Forwarded-Encrypted: i=1; AJvYcCXQyrEtFQ1E0vsbh3hPttgwjFrd0vYo+Xm1ORwTQo6EwcB8alcTPeJN4PBpf77DPBjlWEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcluoFEulRILJVgsgMHJ1nUI7X3IVq/HdIWmVY2o98aD+/4C4
	FobzxuV8JTXmL5Ep1JXElYa6Ll99AmmcwZ3lp9WWrPOiXJYOjPz+1tBEh/MNh4au0/qz+Ci/
X-Gm-Gg: ASbGncu51rPY/jWpzeuLE6nsQGu28pQ4eoQvC/261J91g1nrvbsMOagrUsI3TdSn0Dr
	o+M4uvr+vfSYQzDB5mMUfaJZJGo6GyYZx62z1vrjkaxMkRtMUOgu7GSgUuAkX1JUZEWTAqBO5nr
	3omTy0JsqzBhTKgCptTqbj9AUO3JaN/Pxq+NStkKvT+HvcmDv2mSFKlyd/SdsJyKcSgxTZrbuVv
	KYQaR41o1Kf4xUQ94/jeqyntY44/OjpyI3Mzo7dlnZpta87RES96dB+l586h1HdMizh2yE8UZXm
	HQ2N9GFHYAAQEC11wdGe3jI2sqXIPftu29hvWlMRbD8b9zY4FlGiEDDcjVkE6z0/VV6X0HFTqAa
	y9o4XdVk+Ur0vS14jinF7WuNvVMT4KZAV+dJ1RJ1kz0j/XWdRexuyN+18UuWLQgtikeB2qzmsJc
	6+XZbFW7K/hs/RIk4=
X-Google-Smtp-Source: AGHT+IHTH0JinbOevFQv63FRumPRo26JUUc0qkwllwN1bogjyVzWr4TpTK1y1HuLN31XKsWATKEW8g==
X-Received: by 2002:a05:6a00:c83:b0:7b9:7f18:c716 with SMTP id d2e1a72fcca58-7ca8740ef7emr30483141b3a.1.1764665311073;
        Tue, 02 Dec 2025 00:48:31 -0800 (PST)
Received: from fedora ([183.241.171.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f080beasm16166803b3a.47.2025.12.02.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:48:30 -0800 (PST)
Date: Tue, 2 Dec 2025 16:48:17 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1


From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:31:49 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 3509
Lines: 119

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1



From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:33:21 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 8250
Lines: 265

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1


From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:31:49 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 3509
Lines: 119

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1




From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:44:16 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 17732
Lines: 557

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1


From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:31:49 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 3509
Lines: 119

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1



From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:33:21 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 8250
Lines: 265

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1


From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:31:49 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 3509
Lines: 119

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1





From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:45:09 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 36697
Lines: 1141

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1


From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:31:49 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 3509
Lines: 119

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1



From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:33:21 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 8250
Lines: 265

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1


From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:31:49 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 3509
Lines: 119

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1




From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:44:16 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 17732
Lines: 557

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1


From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:31:49 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 3509
Lines: 119

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1



From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:33:21 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 8250
Lines: 265

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1


From haoli.tcs@gmail.com Tue Dec  2 16:24:49 2025
Date: Tue, 2 Dec 2025 16:31:49 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] slub: add barn_get_full_sheaf() and refine empty-main sheaf
Message-ID: <fqbhzbjw3nvbylvxayboyug7qayfref4xti7udztygd6zbhcun@b7s2yjihrwos>
Mutt-References: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
Mutt-Fcc: ~/sent
Status: RO
Content-Length: 3509
Lines: 119

Introduce barn_get_full_sheaf(), a helper that detaches a full sheaf from
the per-node barn without requiring an empty sheaf in exchange.

Use this helper in __pcs_replace_empty_main() to change how an empty main
per-CPU sheaf is handled:

  - If pcs->spare is NULL and pcs->main is empty, first try to obtain a
    full sheaf from the barn via barn_get_full_sheaf(). On success, park
    the empty main sheaf in pcs->spare and install the full sheaf as the
    new pcs->main.

  - If pcs->spare already exists and has objects, keep the existing
    behavior of simply swapping pcs->main and pcs->spare.

  - Only when both pcs->main and pcs->spare are empty do we fall back to
    barn_replace_empty_sheaf() and trade the empty main sheaf into the
    barn in exchange for a full one.

This makes the empty-main path more symmetric with __pcs_replace_full_main(),
which for a full main sheaf parks the full sheaf in pcs->spare and pulls an
empty sheaf from the barn. It also matches the documented design more closely:

  "When both percpu sheaves are found empty during an allocation, an empty
   sheaf may be replaced with a full one from the per-node barn."

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---

* This patch is based on b4/sheaves-for-all branch

 mm/slub.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a94c64f56504..1fd28aa204e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2746,6 +2746,32 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
+static struct slab_sheaf *barn_get_full_sheaf(struct node_barn *barn,
+					       bool allow_spin)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	if (!data_race(barn->nr_full))
+		return NULL;
+
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
+
+	if (likely(barn->nr_full)) {
+		full = list_first_entry(&barn->sheaves_full,
+					 struct slab_sheaf, barn_list);
+		list_del(&full->barn_list);
+		barn->nr_full--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
 static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
 					       bool allow_spin)
 {
@@ -4120,7 +4146,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool can_alloc, allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4130,10 +4156,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	if (pcs->spare && pcs->spare->size > 0) {
-		swap(pcs->main, pcs->spare);
-		return pcs;
-	}
+	allow_spin = gfpflags_allow_spinning(gfp);
 
 	barn = get_barn(s);
 	if (!barn) {
@@ -4141,8 +4164,21 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	if (!pcs->spare) {
+		full = barn_get_full_sheaf(barn, allow_spin);
+		if (full) {
+			pcs->spare = pcs->main;
+			pcs->main = full;
+			return pcs;
+		}
+	} else if (pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	/* both main and spare are empty */
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
-- 
2.50.1






