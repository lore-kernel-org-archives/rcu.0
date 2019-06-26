Return-Path: <SRS0=LF1p=UZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B504C48BD9
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0AD208E3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctr9s/7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZUHL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:07:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36862 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfFZUHL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jun 2019 16:07:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id w7so103007oic.3;
        Wed, 26 Jun 2019 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdmbHMmbSNut95d3F0ceTiRWRbWxom01SWzuAnwfwoI=;
        b=ctr9s/7OinhanOINCxbDHM1Ecu+3kbYCu3EVAMNWrLBkVYubxrN4PBeeV4g9VWV3gY
         oLqV2I0/oiFiyImjuBDTnFSXCLwSmPAUn4Hk9FbKRSOdwlMkB3elw7hyM6TeP7cbCNB7
         0u7qQ83hHEXKqYlA4V876Jr9rwJ4KBD/rJ1AIIyXfhssjSd+/J2GYQumoXsEAJRntaIH
         gkycJxk7KC+SzZIIC9JsmAnQYF5bIUuaX13uheYxnIQk3ukb01MhCq9CQCP2k+woT7n8
         Izq10P3vJsInycsMl3wBE8NVBjhj57cHibHIAdbMdNaczrxzN0nys/v4SQaStk+O6BEO
         vKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdmbHMmbSNut95d3F0ceTiRWRbWxom01SWzuAnwfwoI=;
        b=s67DgRi+rLYX8i1I5FG6UWBQ10y2YNBbTdWJEZcSgRhNTtuc5Cvxc0KnVPG6laPR3x
         Lzx6whMp1j9ojJGY+z4eLsm6IYLi7VsN9vl+KHYxqXFyo4dtZM2WK/mxmwz1FgvzQ4Q2
         cN/QgXEr8miahF+wg5e3JbWVTzk1bAODv5Mpl0BaHjxepsrnm9HGq9qhHJGrN/diCkge
         rmbxp4MLeqzVAcvZw1qUPwe4KuztW+EHbMrn2vy0tedxa9Ln4c/SvcGSLA66r6okYDz1
         3gBnL9XA3jg9MpDYpN4Rpfpw+Hi+VmKoC/xrfg+L+/fnxSmMsKtAbFTQcF1AE6H/wHc0
         BcZA==
X-Gm-Message-State: APjAAAVUsvyli/qEN0cX3pKjF5oFTy3+J8P9/ANtGW6v9kS6hO86EouG
        OegilzatecsLQdQutSkCIhc=
X-Google-Smtp-Source: APXvYqyj+/HPtwGoz16TAu1EV3XmAIOYq8V2p9ZdpuKh2y2+TrI5WlMS+Ge0yb5J3v0IY4wRC6lilw==
X-Received: by 2002:aca:e588:: with SMTP id c130mr114925oih.166.1561579630993;
        Wed, 26 Jun 2019 13:07:10 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id l15sm6952771otr.38.2019.06.26.13.07.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:07:10 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v5 4/5] Documentation: RCU: Rename txt files to rst
Date:   Wed, 26 Jun 2019 15:07:04 -0500
Message-Id: <20190626200705.24501-5-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626191249.21135-1-c0d1n61at3@gmail.com>
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename the following files to reST:
  - rcu.txt
  - listRCU.txt
  - UP.txt

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 Documentation/RCU/{UP.txt => UP.rst}           | 0
 Documentation/RCU/{listRCU.txt => listRCU.rst} | 0
 Documentation/RCU/{rcu.txt => rcu.rst}         | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/RCU/{UP.txt => UP.rst} (100%)
 rename Documentation/RCU/{listRCU.txt => listRCU.rst} (100%)
 rename Documentation/RCU/{rcu.txt => rcu.rst} (100%)

diff --git a/Documentation/RCU/UP.txt b/Documentation/RCU/UP.rst
similarity index 100%
rename from Documentation/RCU/UP.txt
rename to Documentation/RCU/UP.rst
diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.rst
similarity index 100%
rename from Documentation/RCU/listRCU.txt
rename to Documentation/RCU/listRCU.rst
diff --git a/Documentation/RCU/rcu.txt b/Documentation/RCU/rcu.rst
similarity index 100%
rename from Documentation/RCU/rcu.txt
rename to Documentation/RCU/rcu.rst
-- 
2.22.0

