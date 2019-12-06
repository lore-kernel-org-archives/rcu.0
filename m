Return-Path: <SRS0=+k02=Z4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17318C43603
	for <rcu@archiver.kernel.org>; Fri,  6 Dec 2019 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAEA2173E
	for <rcu@archiver.kernel.org>; Fri,  6 Dec 2019 16:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lnAxMEOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFQAE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:00:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38064 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfLFQAE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Dec 2019 11:00:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so3300470pgm.5
        for <rcu@vger.kernel.org>; Fri, 06 Dec 2019 08:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yp4NDcto5u3LEI/hPsxbY59xGgx6y4i/6vjXYjtnjow=;
        b=lnAxMEOEHX+2ySVymkjh100nDEHcIL4fsUSOKlWMR5nDBzDCp4AATKxrpWzWyI8Dk4
         zg58wU4yvgBvfrNP1HGcAvWjaydR5zG2JJOEldi2nbebNK0efx4k8YZTKryX3VIvQOyb
         lo74CFW4MxylA/c6L7/iqA0GePoca2b3t8d3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yp4NDcto5u3LEI/hPsxbY59xGgx6y4i/6vjXYjtnjow=;
        b=LDvzsHtbF1LW4uy1stCItQOSeNOkDaMvR5dLKeO3o/fNq954dKmReBvIuJv5fbZNcu
         0sSsq+hWjlDbsJSo/4dWlhDeFQ0AQLKVNMOI8QoPwJrZvB7B9Fo5t3bU4IHV5UBjLH56
         tLC6xB4WKJhNgOVbY98V7fL3JKEp0lhQSdmf/UhMNb6W/AfgcWV4s1Pq7LZlJNOVo31i
         wANx8/KvZ41S7/Ndxxqt2fZpeh1OJfCQReu+wq6gMJFu+t0dreyMKImP8EP8vG4s5LHV
         SH6zwSI2Y0jWB3iFkSqZ8+iuagAm7Y8PB30V9Kow47MVzwiMAiHGzUjFKJwoZ6Is/h3T
         59xw==
X-Gm-Message-State: APjAAAXA4c/qQcQE8+RZZUiBQ60WTixyJ0O6IdyiYPvsliYC64d0OKZP
        8RZZlF5LwL/SA0J+0n35YLF8wA==
X-Google-Smtp-Source: APXvYqypv1DWB8/LOdDKSMQkxkwrrdr8pO+nq2V/VfOTVcMO5ym9WNe6AXU+sPVo6aMYwGOSopGp9Q==
X-Received: by 2002:aa7:9315:: with SMTP id 21mr15127246pfj.187.1575648003565;
        Fri, 06 Dec 2019 08:00:03 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d14sm3740684pjz.12.2019.12.06.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:00:03 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:00:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Message-ID: <20191206160002.GB15547@google.com>
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

+Paul, here is the dependent patch for the list_prev_rcu() patch Madhuparna
posted.

On Fri, Dec 06, 2019 at 08:46:40PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch fixes the following errors:
> fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
> fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
> fs/nfs/dir.c:2353:14:    struct list_head *
> 
> caused due to directly accessing the prev pointer of
> a RCU protected list.
> Accessing the pointer using the macro list_prev_rcu() fixes this error.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> ---
>  fs/nfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e180033e35cf..2035254cc283 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2350,7 +2350,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
>  	rcu_read_lock();
>  	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
>  		goto out;
> -	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
> +	lh = rcu_dereference(list_prev_rcu(&nfsi->access_cache_entry_lru));
>  	cache = list_entry(lh, struct nfs_access_entry, lru);
>  	if (lh == &nfsi->access_cache_entry_lru ||
>  	    cred != cache->cred)
> -- 
> 2.17.1
> 
