Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BF307AD9
	for <rcu@vger.kernel.org>; Tue,  2 Dec 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764666024; cv=none; b=sMCbbBEGkaugIHWxV7nutmA8IoqWGOFWMdgsJZhKvHbs/S4h2MBIDbyY0FlkvLVrlu5qFpTpqjuU+MgxgpFa4w1wc9fPbhR8XR7jaNnLr/yUHhv/l3w0oaCV5thWj06ZUny4lNEBQu5+goG5F0h1nDypEFf1yDYHKlMsXZDxsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764666024; c=relaxed/simple;
	bh=6U0wc5j7itDMrkk9cvcAeQZkYbCa1ocpdtIssIpDS5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glv0FrPqmrwZ1hu/Paxm8mSrYV9O06oxGeH+NGvr//mlvkNpcTNwEUMwMHqkJ2WEsqDTBXRRxgbyND6nsB0hCWVbBWj0lTj4B4uZP32Ed82dJRRdJwnS8fp9UWeClofSPd+2stL3dIie+xR/AajmG5l/50VLHfu/CNB1slLp5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grMAoV1/; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grMAoV1/"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso8409291b3a.2
        for <rcu@vger.kernel.org>; Tue, 02 Dec 2025 01:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764666021; x=1765270821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDtCgcKoqebXyo+jxENam+HXtRH1ghw4HvSFLZRxozg=;
        b=grMAoV1/0CN5JyiyEB8PhZk8cWMvAd7TJqWOdHjHs5DQovH52GT5X7/erJFNnmHUij
         hbBgGT5IaUmTi6BIHv9OIKcgw4B1rDigQu43Iv9o0kersd85zh9nM3NOVLxNKrPL28J5
         ECaD7/keElej8CyrAiexFNNFfeU+mG4uBOWBfpPsQnIG13lw94hK2PnsuwLcdQL2ekzV
         3T+U1K+QaWKOZ5zlIfxTk2C44BtNiTV0id99w/OfX6SKoX+EWnGY4P0ue1qprQ0vybuo
         XtwNPRDM73pxPNUPBlHAlmWCZnCAjIsuoTSOnosH/0D3jTSVAUDcMdM+OnVhq+gLkmOd
         aIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764666021; x=1765270821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDtCgcKoqebXyo+jxENam+HXtRH1ghw4HvSFLZRxozg=;
        b=huvsBoh22pExKYISUTwIx/uMaZy6berN1BnX1ZsMDPKcs//0my9M8/TL6Y8DIdZzIQ
         sPctA4a6FPSTwWa063ejo9pzM93fqM1Ty4kuJ92dm1R+w+wTcZBhYfGy6An6pvKpjxdK
         pKIX6CHku3GNySSf6s/Zer8R+ZphGWRAnf9rGfNukNG8+rr41NNoTSBJB+LWABbuO47i
         LC7A6AsA/8MjjEi0rY4f2ZRGkYKRGPItEA/qzWX7hsNP9hjIzMKgsTQLIpFAxrge1yAM
         Ae6SyGal20HvyeYShTvR/irwwjtnsCgE41j9/rVhfG6aosohwZ/FG0Sil4RkDrGWuPBX
         XDtA==
X-Forwarded-Encrypted: i=1; AJvYcCW/lhZBJhKD6KjBmM2PGKa8UT7KAZ120fju1VgbJUL7IpViypH58sBE174C+t/SMG/i/vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRlfpbLxz0fNlBF1eaDvMSjl7NkXzBlICpgorBIw+hNtdQB4h
	b1Q9lmU1EXrHJ6qLVIDW1gYknHANPkzNasvdIaaMSo4Gc/y85v0P9JbC
X-Gm-Gg: ASbGncsYeyGN8yf8pJswrT47Ms8GFuoepEn3GDLD4PAB3biznRBrgfDs7PQ6ZeHYMJz
	TgnUXvsXnQCyB5575IFJhU2dbEi6OXXZ7FyT0eJrSZJQfWOdcInX77HeGEch2dDf06/O1LwGHVY
	kDC9TcX0gKxBhhd0TVrOyYEsioyEOuGf7TOoFLqQB+wAoktEhfLun8qNdyLJtWdvRQv8VP9xdyU
	ySC8f7VyFROkqsiKfAw+KjiRSlhlbWDZVofUdPCcYa/dj0MkulqzA4DaHxrTGLpPBtLTff9e7KO
	Wpp5eEg16mqDmHDYy5bylRsdhlqKh7x3d/eBCXt4//N/Hcb/fdi1zBitTINjslFRdL8qO0gaXds
	2JFAG08a6wjtyJjef5HByNa1FvHNljvW3ygmbzQ6fbNiijkB9fM/QXJ672ygt0lojVq0dVpY6NC
	h9VkbN
X-Google-Smtp-Source: AGHT+IGBTBGTbAUOxAz4LdYDBbQj7h1lJpYS6bSIIDqI1Q6AFazDjtAmDH/mUQRFh29VnLmHXujLxA==
X-Received: by 2002:a05:6a20:548d:b0:35d:3523:c90d with SMTP id adf61e73a8af0-3637d8d6789mr32627334637.0.1764666021403;
        Tue, 02 Dec 2025 01:00:21 -0800 (PST)
Received: from fedora ([183.241.171.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150b68367sm16385575b3a.12.2025.12.02.01.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:00:21 -0800 (PST)
Date: Tue, 2 Dec 2025 17:00:08 +0800
From: Hao Li <haoli.tcs@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: slub: add barn_get_full_sheaf() and refine empty-main sheaf
 replacement
Message-ID: <lvagftdnxgpyafafl2ish6x6phno6xstd6r3zxffs652lyxzyc@2pbngufu7wro>
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

