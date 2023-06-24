Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC60EB64DC
	for <rcu@archiver.kernel.org>; Sat, 24 Jun 2023 03:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFXDOP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Jun 2023 23:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXDOO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Jun 2023 23:14:14 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE1E47;
        Fri, 23 Jun 2023 20:14:13 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1aa161c3796so1213550fac.1;
        Fri, 23 Jun 2023 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576452; x=1690168452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZj9kRSuBlBukl9uM0KLWNA4kwPzrxPQ9TSaIxf8hKQ=;
        b=S518s2v2/AxnQdou/ec0ySauX36NoAlE9dwdT3v6e56rWscgtPySW+6m3ow/KY0kTU
         ncwz/apbtHT2qzknWQCRRgaxzgvLcIbhsj0oDdwJYCs+l0Do0zYD3OcSJ82Tj0VpLQ9M
         pRB/JitwBMm9gDsd5dl77JE4rHZf7xr9AnNM5ztivU1l1CHKlMHrPHuKOJLZyBpj5m74
         9avVzPuBuPZTK5fUP4KvKoAjaXPqKkB3sUGH8a77AMButL7bm/rx6gPjUhSubwHBQlj3
         d55vTjgiTQjE/2vVBKK0E3Udpek7eISn3EfBbPYanfUNRqs3GRAKMWAOqGJi+0MFjXPX
         QsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576452; x=1690168452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZj9kRSuBlBukl9uM0KLWNA4kwPzrxPQ9TSaIxf8hKQ=;
        b=QblBKYPyz9oQ4ZIIWp1WujDLqls9xNYrCKARYAz1KWXzHNcbbxoGZEIxk2TAP0fVgi
         xuMudFOyhmhkZpBmmQe9U7IL4geE6JrKHpMP4FmzgA/4Kwtc5/F8II/ZVHyrzI2mCzWk
         jct6PotFlLYbgbAMeCIhNF5/YnMCdahePki3iw+5tSE4aQMXq/WArnn/1g1zZJTNNzDV
         dOBD1L36ahbU+9xJYV5rz81iW8qWbYMGReAwXIKFnSSztqssiy/bgD/xBkqPmUFHt2Q8
         Ol/BiW+QHthHeSQpBmeYAY+f+4IU5uqcCvZr+4oMbKgh3uau0gy01RAEeXdwqVwhWEWB
         F0Cg==
X-Gm-Message-State: AC+VfDwYKR+edrQ6+qx6ljvsJqi/0I3zMBg5VsTMZIgQPPOVoKa3KctV
        0oVEPyguZhBSSXkKrv+gsos3kRt7DJU=
X-Google-Smtp-Source: ACHHUZ5d0cUQNzbtP0/2qASt0GxeEAHYs65WJsM2C8LQcbeUMy92C/1iI1zKAN+ogAY1eAAES9n+CQ==
X-Received: by 2002:a05:6808:1cb:b0:3a0:3e86:3c with SMTP id x11-20020a05680801cb00b003a03e86003cmr12249246oic.56.1687576452342;
        Fri, 23 Jun 2023 20:14:12 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902b70300b001b3d6c86ffdsm239753pls.156.2023.06.23.20.14.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:11 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 09/13] bpf: Allow reuse from waiting_for_gp_ttrace list.
Date:   Fri, 23 Jun 2023 20:13:29 -0700
Message-Id: <20230624031333.96597-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

alloc_bulk() can reuse elements from free_by_rcu_ttrace.
Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary kmalloc().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 692a9a30c1dc..666917c16e87 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -203,6 +203,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	if (i >= cnt)
 		return;
 
+	for (; i < cnt; i++) {
+		obj = llist_del_first(&c->waiting_for_gp_ttrace);
+		if (!obj)
+			break;
+		add_obj_to_free_list(c, obj);
+	}
+	if (i >= cnt)
+		return;
+
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
 	for (; i < cnt; i++) {
-- 
2.34.1

