Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B61114
	for <rcu@vger.kernel.org>; Fri, 12 Sep 2025 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757637546; cv=none; b=hnlT7IIPoZncQ0eCsSIk9pvP52tJHGxY2/OAy37MGmmSX/3uxPAuySGDUfj7k8EPFu9fORmcvVPk3egUP6f0u2+M+O5CaXHdW5Pit2iY2z0CaYmXNZRr9wwCj06BymkphLyfQFFshT1WL6CaJBkyQT9ZYhQJ49yUr7bs6LZSPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757637546; c=relaxed/simple;
	bh=2VWetjtrxig8JtjKnKwnv3PUIASCuozn6yIHaW6gzMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1k5J6Te/2kLX8xOCjCRZLV+RaxuUIGTUsFSqNjH5G140eRChreSexrOZy8O538MjZBZmE9F8wJIreTTKVCV9L/PLjku/+I3xtaTWk6Zy0lHfuO6Me/bRiTSizxe/S3SwQYXa6NnXAzW1T+JeEsquJXHEyiZgmHVKLMelfriY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IlRtv3zL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IlRtv3zL"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b92d75eaeso1136373a91.0
        for <rcu@vger.kernel.org>; Thu, 11 Sep 2025 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757637544; x=1758242344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pygF7jfRzgyoJR+RbnAP81gGP/4eRj7+xtnD/Gk+w+8=;
        b=IlRtv3zL5X+vFy69DRsWKa/CG2EAq4W6LgBYA8nRLduco7PW/3Cu66Q+54JbvnoncE
         zDbgIR48JD0akO9MuVc7EFpQOKqpRDJmqyCqFKdD4VgfLgQ7hyuphrjVGc5x5BdhqzJ5
         MMT2tnOkyd60oJu7XsuaIK3HQpb1pENRZ1he0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757637544; x=1758242344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pygF7jfRzgyoJR+RbnAP81gGP/4eRj7+xtnD/Gk+w+8=;
        b=VKAB0D2yIjvStaf1CAkWSIrbuZhQh39si1AN+N6JWglp0sCGeOFEKgIgHHr96r/x5l
         z5JpXgOfFMAr3/PHNmJ8XXRUHqWKvlyeNm+bKtu0XAtjYInso57yLvqHrGQE9kAIHjdo
         tS8h3w7zJP78y/qRpR+Hg8S7ix5YMErr7FsF6HseP9+ssCgdk/0fXNCbf5gl7ouDAniA
         AjMp1sUXoMHA8zF1NXQBif1xMQzwplKw2WIZJ4sbv4VHIG7QOV1LBxYlnUQzw+FoACk8
         DY7iym14BSOcmLodYofqTK+wK692+34r26qx+3V+89f+X3eSIUnK3myWXreOL4p9quQ+
         yEog==
X-Forwarded-Encrypted: i=1; AJvYcCVwf5c8HcovD+vL5lz/65M4JoRWpges6C51COgxOJK4WhAtJgyEh+0Wqd5Wos29/odiDSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0iP6bBgV0IFm9W49jHk8ZlyLWR8CAWl18zSJ29EwzwvjX6Yr
	C8RLrnA5AoC/diRJcziHUZV9h3H19aWAoqXwy4W5ZT4cSmzoLGD3uQF5hCFfm0t9ePZD2Ss2OWC
	MvJY=
X-Gm-Gg: ASbGnctvTGU+QxGZ3h7qlTUeqIdSz2yEsetT2uzI5sPDt/7iD5I83Bv09l4uDEwhKGz
	AYMV5+R26KB2B1Vu7t+Kzo62JZzJ4Cj/j6UrIbrhK7J3T6YZu8WaVnLKy1WrrCcadmNP8bhoUe7
	dskejzhqhDDwDVVx8UQtjPCy3j2uFx1NkSmbSTFy221c41tQtprGaqNzdsoSftjIG6CnHSNhOEV
	DKb6vpiyJTQqqvvFAIxeG3+/Myxd8AIYm5mmifrckJot6m9gtkn9fFZR0VDgg7yR7oCkXBG1+1d
	wWMJMnru9zexo+uVTW6Zn47JeqVBlCVyb0X9uOfGG06xAPPMly3bmi4tWr/Rj7YdnklefjbWQQg
	WBs2dxxXwHrc7Rx1+fUD6/jnmuA==
X-Google-Smtp-Source: AGHT+IHzT3QQNVRvVSz0tE7xG6V0WgOvZURC67BN1xRkbpT5lpSEH+gWhcZm+P+aIDdhInHKfnPrvA==
X-Received: by 2002:a17:90b:582c:b0:32c:7693:1138 with SMTP id 98e67ed59e1d1-32dd1dd8939mr4799954a91.14.1757637544012;
        Thu, 11 Sep 2025 17:39:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d93f:86ed:f2c4:218c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b5fasm3501595b3a.16.2025.09.11.17.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 17:39:03 -0700 (PDT)
Date: Fri, 12 Sep 2025 09:38:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <iycnfietmsgggxcdjuqngjuzbuygsxfpvkcz2fwm4frdxin42u@pxhmqcgejnov>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>

Hi Vlastimil,

On (25/09/10 10:01), Vlastimil Babka wrote:
[..]
> +
> +	if (rcu_free)
> +		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
> +}
> +
> +
> +/* needed for kvfree_rcu_barrier() */
> +void flush_all_rcu_sheaves()
> +{

mm/slub.c:3960:27: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
 3960 | void flush_all_rcu_sheaves()
      |                           ^
      |                            void

---

diff --git a/mm/slub.c b/mm/slub.c
index 11ad4173e2f2..a1eae71a0f8c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3955,9 +3955,8 @@ static void flush_rcu_sheaf(struct work_struct *w)
 		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
 }
 
-
 /* needed for kvfree_rcu_barrier() */
-void flush_all_rcu_sheaves()
+void flush_all_rcu_sheaves(void)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slub_flush_work *sfw;
