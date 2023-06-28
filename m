Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F598EB64DC
	for <rcu@archiver.kernel.org>; Wed, 28 Jun 2023 01:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjF1B4y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjF1B4x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jun 2023 21:56:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30F3DA;
        Tue, 27 Jun 2023 18:56:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so2046510b3a.0;
        Tue, 27 Jun 2023 18:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917410; x=1690509410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5dE0XhJvwd5u50dMmi7rGk+uakRp6is0d4Rg5rl7Ow=;
        b=T/jVIlCld2/l7E90KQE1BYw6tsDeUzwlSRdvG+R0bsCHcqSR3US577QKke6tnxUePg
         8iSywElkXrbW8KvLL3hV6QeGKrtNHWmgFOjiLAxpdgZwpsJ94h8YaLPqVoGARGQ7VTdI
         vxUfuAMwSRovljIM1C4uYR5P8QygG9CEHxfMpN71hyUDWcXL/ig5rqzp5OdXo528XbFk
         6d4+ls0ZaHg5gWpkQe2v0wB+kdqse0TF9+t7Rz6S9KyI7XRgOhCDGCQfNdUsvSPosFVg
         O+hrPHKyxP9NzIbm70sbUvOd+c0q5w3CFok475G0sc2M2/ycbDkPee3FbxBg6VQYWRSP
         jrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917410; x=1690509410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5dE0XhJvwd5u50dMmi7rGk+uakRp6is0d4Rg5rl7Ow=;
        b=LTS2EVZIbFwruYtDemaxddxKhe6idCfnDI1rJ8AFudsCQ9qYe9HMLmBJheMamj3GQ/
         oFy1VB1MopnpecRSTgxE96w1bskts74EcDDIabvH3G6OcKG1axF7PZhbtuWDW2BgejCv
         8aKm2gcsqzATv0OroATK0Sjvnm5TOHsGDzYdo0Yk2EWEvs5/S1eJUsqysx9T2sIte8s6
         Qr8/MD3uUOEBEEP2LWfeQaua7MLy3xqzJx0m49oSm8DAWD++JFNwRZGpLmbsiilGL2qL
         sRVnGJXSgW5tNbKc5VzkmTHtV9GfkdZ7K+CjbOZ4SQlT5HGWIOv/30f+04+KPFyTpmPQ
         5UHA==
X-Gm-Message-State: AC+VfDz+/4UR6H91UWEavTrRaVeZKLDh66OspxEzmcvmk0BbjlTN14ON
        786W/Xivo/6AW8uT1aLW7zk=
X-Google-Smtp-Source: ACHHUZ7CdQC4V9yJhdznKoH3684v5y1m5kvH7KSTmluDHlAIzUw0TW3gs0Top+Uk+5T76LO3q8sTuA==
X-Received: by 2002:a05:6a00:2394:b0:668:73f5:dce0 with SMTP id f20-20020a056a00239400b0066873f5dce0mr22330814pfc.29.1687917409783;
        Tue, 27 Jun 2023 18:56:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:6420])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78813000000b00671aa6b4962sm4771247pfo.114.2023.06.27.18.56.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Jun 2023 18:56:49 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 03/13] bpf: Let free_all() return the number of freed elements.
Date:   Tue, 27 Jun 2023 18:56:24 -0700
Message-Id: <20230628015634.33193-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Let free_all() helper return the number of freed elements.
It's not used in this patch, but helps in debug/development of bpf_mem_alloc.

For example this diff for __free_rcu():
-       free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+       printk("cpu %d freed %d objs after tasks trace\n", raw_smp_processor_id(),
+       	free_all(llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size));

would show how busy RCU tasks trace is.
In artificial benchmark where one cpu is allocating and different cpu is freeing
the RCU tasks trace won't be able to keep up and the list of objects
would keep growing from thousands to millions and eventually OOMing.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index b0011217be6c..693651d2648b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -223,12 +223,16 @@ static void free_one(void *obj, bool percpu)
 	kfree(obj);
 }
 
-static void free_all(struct llist_node *llnode, bool percpu)
+static int free_all(struct llist_node *llnode, bool percpu)
 {
 	struct llist_node *pos, *t;
+	int cnt = 0;
 
-	llist_for_each_safe(pos, t, llnode)
+	llist_for_each_safe(pos, t, llnode) {
 		free_one(pos, percpu);
+		cnt++;
+	}
+	return cnt;
 }
 
 static void __free_rcu(struct rcu_head *head)
-- 
2.34.1

