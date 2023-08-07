Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D9EB64DD
	for <rcu@archiver.kernel.org>; Mon,  7 Aug 2023 11:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjHGLYO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjHGLXo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Aug 2023 07:23:44 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68EB4C2D
        for <rcu@vger.kernel.org>; Mon,  7 Aug 2023 04:20:50 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5648fca18b9so575088a12.0
        for <rcu@vger.kernel.org>; Mon, 07 Aug 2023 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691406867; x=1692011667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igblsYgdIrcTAL0swCZj529c9jjsKo5CwfFS1Qcng2s=;
        b=E/hLPt4J9XwFdy6Q/ScFkKAboS35nT/aVetijUs1uOyzpCdXJrzvux0WuTkbJahYDU
         HJ4RnOFgFoSV4vIvUSABYCFS8MT8O5BBdFRn/e0d22QvpkBHCvD7k0jL91l8VKqh/AnF
         pNO49bmGYrjFLlyM+it2E7+BjcoRQ4qvC4Z3zAnwRx4Mtu2gDzO6KjINZG5u37W7YPwR
         rd9mA5oeLZ1tw0ARUeeWuqEeVLZXyyZpLkD+mkbNh9jB2r9y+xHrPRtEaxpg/6wzvL2p
         pP/svPPe0egiR6EyNxAsA97H1SimGEidDNnScRjB0NSGHk7qAYW8vH7pvvrUaRXF4mmo
         0r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406867; x=1692011667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igblsYgdIrcTAL0swCZj529c9jjsKo5CwfFS1Qcng2s=;
        b=HvCC2+2ht5VrQHxoy64f4dTyi7N9ifIbkzSrHrbv/ZeDjlS2NaLfn95/g6irWGEDGZ
         D2AGesLPdPJcxr5e/zeA/mAqXHJpBr2QQU+0OfRXXto+/vPQDYA9y0yAWXbZEjA4ZQcm
         tlrwBk9MuA9DuPWwIbHeW1xeKOSYuUvA6kFYb5hGND39mSIF4ORUCur4bA9Gh/UECMWR
         GiVAyW1UTJzIYvivHcIuDf2BV2r1x2NSKZoqeXfAlnkoMx6IdziSqFJoe5wlFwf0NP+/
         RVR47ZrSL2ID4khABPC6IHWj4wpEpEGA+2hM4wYKJDio3iMEPVz76pSG6qDrbcXRlsRM
         YiSQ==
X-Gm-Message-State: ABy/qLYWPBgI35ZBnkm0GCI3sB/YhiIhkiOvEMYWUuKRAtAhC51Qc7x7
        VJG8ldzJGResMZqcP+3xOOZnDA==
X-Google-Smtp-Source: APBJJlGEDKqK4nyUWs8xE2EOJL+ODt25deDnA1/u8sHRAURqC7uD6bjxMDwwed+SXn6y84Un7sE7wA==
X-Received: by 2002:a17:90a:1090:b0:268:126c:8a8b with SMTP id c16-20020a17090a109000b00268126c8a8bmr24570134pja.3.1691406867003;
        Mon, 07 Aug 2023 04:14:27 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:14:26 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 21/48] sunrpc: dynamically allocate the sunrpc_cred shrinker
Date:   Mon,  7 Aug 2023 19:09:09 +0800
Message-Id: <20230807110936.21819-22-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Use new APIs to dynamically allocate the sunrpc_cred shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 net/sunrpc/auth.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..0cc52e39f859 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -861,11 +861,7 @@ rpcauth_uptodatecred(struct rpc_task *task)
 		test_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags) != 0;
 }
 
-static struct shrinker rpc_cred_shrinker = {
-	.count_objects = rpcauth_cache_shrink_count,
-	.scan_objects = rpcauth_cache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *rpc_cred_shrinker;
 
 int __init rpcauth_init_module(void)
 {
@@ -874,9 +870,18 @@ int __init rpcauth_init_module(void)
 	err = rpc_init_authunix();
 	if (err < 0)
 		goto out1;
-	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
-	if (err < 0)
+	rpc_cred_shrinker = shrinker_alloc(0, "sunrpc_cred");
+	if (!rpc_cred_shrinker) {
+		err = -ENOMEM;
 		goto out2;
+	}
+
+	rpc_cred_shrinker->count_objects = rpcauth_cache_shrink_count;
+	rpc_cred_shrinker->scan_objects = rpcauth_cache_shrink_scan;
+	rpc_cred_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(rpc_cred_shrinker);
+
 	return 0;
 out2:
 	rpc_destroy_authunix();
@@ -887,5 +892,5 @@ int __init rpcauth_init_module(void)
 void rpcauth_remove_module(void)
 {
 	rpc_destroy_authunix();
-	unregister_shrinker(&rpc_cred_shrinker);
+	shrinker_free(rpc_cred_shrinker);
 }
-- 
2.30.2

