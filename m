Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A05C6379F
	for <rcu@archiver.kernel.org>; Thu,  2 Feb 2023 21:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjBBV5C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjBBV4y (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Feb 2023 16:56:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5957908D
        for <rcu@vger.kernel.org>; Thu,  2 Feb 2023 13:56:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q10so3002334wrm.4
        for <rcu@vger.kernel.org>; Thu, 02 Feb 2023 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlEYiVjRJdjrX9c53b+gnJjwRka4ZmK3zw3dl+LycL4=;
        b=d28IFYmZuelC4BmIuIijPPFJKpeR6Lv83DAOYl4C9BGbHQihhQo9hhtpVtUE0YuD1x
         Lr1fxDrkMlmUXMbyUMMeurglo0UW/JarxML1HYH9eZU6g1cuxtYA6wa3kEKN1R5QrMsO
         DETcwBPXpbIBOEcAOeTrgbNYwfJ0CX0qsEsRmn25jT9BeKrRqH7ioIaIFMDP5yKOpsry
         HPj4TEQ+A2OvEBANu8jibDM8tqIXtc7o0Z5wcBwo889u11HqaidUFya+h88bCt/WL3R+
         n6evjrchUjg1Hf9c/fK6B0eQju+6VN81uY3sL3ZARvXIsO/3/K2UUkluvJzah5kr1VsK
         u9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlEYiVjRJdjrX9c53b+gnJjwRka4ZmK3zw3dl+LycL4=;
        b=x9itflYPyUQc3Aa0/zGts4QvheFGpMUW+AuRK24xcTzuohBU/nzpwZDNTkTGvVb3Jo
         wQXHV7zXZlyBJxZRI00Pedf9NDvXpAXETinVZ+OXuO7of33OYURLa7k7EUVn6XTcXmBG
         tqw1aRSdt9sJyDwXRWhThV+Zu5Sh/bd7Hl2odKLWLF+SkjUd7/SZv0tIbTCc2Sq/DPjF
         bnHDPs8Idfna1fRZCFl1EPrNQDflgDzfWehl7Bdfcjc4t/EWWvD42aZR0WvFQrZQoUVa
         4knhrGJPP8HsFGXCmoEuHZPbvv1ZHpSnCq0HqdyjMfPr7RhQTOgwEURqdJKHGsPEb9x9
         9txQ==
X-Gm-Message-State: AO0yUKXKeYwf3OmkChj4qtIphjcTrgk33OGkFFGa2fnWJ/PI7JSh6xIa
        HhMlhVGHS9rxm5qPRIPtx2eV8g==
X-Google-Smtp-Source: AK7set9vN+elj/A7UVERmpDS7I923p0GCEu+6d11KV7kTaut2fKwxlBkP91Es2mAI0NSHNtAQz+Tlg==
X-Received: by 2002:adf:e351:0:b0:2bf:95d0:fa5d with SMTP id n17-20020adfe351000000b002bf95d0fa5dmr6988999wrj.9.1675375001192;
        Thu, 02 Feb 2023 13:56:41 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:98fe:e4ee:fc7e:cd71])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d6d08000000b00297dcfdc90fsm506078wrq.24.2023.02.02.13.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:56:40 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, arjan@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v6 11/11] x86/smpboot: reuse timer calibration
Date:   Thu,  2 Feb 2023 21:56:25 +0000
Message-Id: <20230202215625.3248306-12-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202215625.3248306-1-usama.arif@bytedance.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

No point recalibrating for known-constant tsc.
When tested on a 128 core, 2 socket server, this reduces
the parallel smpboot time from 100ms to 30ms.

Not-signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/tsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..bab8a98080cf 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1569,6 +1569,9 @@ unsigned long calibrate_delay_is_known(void)
 	if (!constant_tsc || !mask)
 		return 0;
 
+	if (cpu != 0)
+		return cpu_data(0).loops_per_jiffy;
+
 	sibling = cpumask_any_but(mask, cpu);
 	if (sibling < nr_cpu_ids)
 		return cpu_data(sibling).loops_per_jiffy;
-- 
2.25.1

