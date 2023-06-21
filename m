Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB64EB64D7
	for <rcu@archiver.kernel.org>; Wed, 21 Jun 2023 02:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjFUCdQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 22:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFUCdP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 22:33:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02889B4;
        Tue, 20 Jun 2023 19:33:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b6824141b4so9699205ad.1;
        Tue, 20 Jun 2023 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314794; x=1689906794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtnIfLf/LPJTKp8G83PSPJyAcD0QiLkQGEhE11oDtAQ=;
        b=Xe/1E+JMggzR2gAo3k6EuEek9c/3RlwT7XNLFTxjYllnvHcPgCxUFxzKsH7+WoXDdo
         cwGsUPASALMliQh+O8nah/PbIELBl17qAnrvJPKFDURx7aMR5fMEbNVMEvI2GhLlDUrZ
         AOBSBwfCRmQQgJhiJ6MNNA6cVFSkPN/0xTNReMlAEc7W4mrYl0Xk5tjFP63OIwRbs5Kr
         QDxLmX8UPHYgDKqAlWul+rIz07YMBwUUUKalocL+gPmSM01HwZAkZJgFJpNntG2cvJFf
         cXa5Y9VNMB0RGH9feLDg3yHx2Qtf1TQNJjtuuMAJCiW3ShTu0NIf6E7nWLZb2CeIfaCu
         ysvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314794; x=1689906794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtnIfLf/LPJTKp8G83PSPJyAcD0QiLkQGEhE11oDtAQ=;
        b=IhuKCDlqC7xNNJmcbiSB+f4RuTX+6aT+hj+N2mVJ7xqo3tbw38+RlJEzuYZ79mvRLn
         zc4AkG/fkNqFF3UMMFJ1Dk7teE49z9CpAFzxhYGXIwRHy6rXRe2vu34CQK4WF+XlDw7N
         rdS2V31JgJ0INqdJJVv8J3k2rp81PUGsG5sV53TB/8v5YnXAiTPGSTIDPFu066/P33QG
         PEnHpHSwGilgYykLh6ShIP9UWtQnQRRnsCQzBfIzTbR5D2ba+3AN2eFQnC59N1ZaQM+v
         I3rigShcEs97crNisCYxvn6oc7hM6bupji8lJMV8k2+WTMZJ3/EwbWibQGL/a1z8zgTh
         DMXA==
X-Gm-Message-State: AC+VfDx0aYsnWydUfh56Jbw0GIyF27iXgYTFLLJwg9iJ7DO3JvS4No+G
        3PE4OVmJAk3sqqVptmn7rbE=
X-Google-Smtp-Source: ACHHUZ6WvrksB8kF5pyesxHwJdU6H/DuUEsC7Cf1lxQMdkzxZxlKpgQPQGVssZaoF/7CAFdRP69RMQ==
X-Received: by 2002:a17:902:cec7:b0:1b3:db5d:e8a0 with SMTP id d7-20020a170902cec700b001b3db5de8a0mr19915922plg.28.1687314794365;
        Tue, 20 Jun 2023 19:33:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b001b5656b0bf9sm2212768plo.286.2023.06.20.19.33.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:33:13 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 08/12] bpf: Allow reuse from waiting_for_gp_ttrace list.
Date:   Tue, 20 Jun 2023 19:32:34 -0700
Message-Id: <20230621023238.87079-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
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
index 8b7645bffd1a..10d027674743 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -202,6 +202,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
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

