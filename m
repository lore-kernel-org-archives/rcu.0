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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E85C48BD6
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8748208E3
	for <rcu@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+Ugs46q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFZUHN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:07:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33034 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfFZUHN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jun 2019 16:07:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so1526007otl.0;
        Wed, 26 Jun 2019 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVx7TN3uczpgALDm/meWiW2fhfm7Fz4RIlU9veMR/Ts=;
        b=p+Ugs46qIVKCUmOpfXCqKulJOBSPYP3e7Tlv/G9l6GNg8s090j+fKu2PmvS3G89zJz
         Z93NvrsS6bpCxh7trB73QmLrlfzJEl8r3fwFG2QIcJGjravhOpTryuIlTWPKWcyYygTb
         U5l4wJfeDvmaJWvLdhV2F0E580LiahV6NK8FKJk60x577ywhbnWiKtIsR+2b8vbTzQLO
         LioiOD7vp85z3+b/cNOj6x0mwtvHwQIhFTHg7Cd+egXHLQv+n5JeQoF6sKuL2xNWpt7U
         Vf747/Oz89VTm+iVMVc/IoDMMnaOss0GbpehwjcAr9t+18henQA7NW6bpP/n9cnAVWai
         /l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVx7TN3uczpgALDm/meWiW2fhfm7Fz4RIlU9veMR/Ts=;
        b=OlXB8t9h9mV1QDiPzjRLyLk0wqKxmWfKxkJR/CClEevHrCTT1xazo967QFjGLh3ihM
         yLsgc8OIK862Iz7W9qLbQZPzpnyjf6wf7Z/oSNzO33SiQU8zZru/gAFdOXPCmK3tOFSZ
         nKEBKPTVkoVhFcVUTMedch1rZgZaSWoiqI4HngkYZy/2sxqbJfl6xZGAyXfGUN+cB5Nl
         ocbbcdC+FzhF4QHM0YXqXIFJ0lQgx0NUUt3P5Qd/N0l6AD4SZ4lt3rUGEO0p0o5xDm3D
         vHuZ4m0iiAoAir8TjfiBsCt0zpz8ImK0mVg/0UD7c7FAkmVhIks9ducod/wvnFJevuPb
         gGVw==
X-Gm-Message-State: APjAAAWt9L5txzmq6XYNRa3oFVkQyZZg+HniHF88oI+y8A+Iz+8jPSVn
        4G02ivW+N9PFRUvWnKpkO3o=
X-Google-Smtp-Source: APXvYqygQnFTaAFQeFUr63bQP0xPoM8dSY0rM+r7vm0LmLJujvqRH4VVTjjRl50Y5wU07fiW7pIyhw==
X-Received: by 2002:a9d:591a:: with SMTP id t26mr98357oth.170.1561579631732;
        Wed, 26 Jun 2019 13:07:11 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id l15sm6952771otr.38.2019.06.26.13.07.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:07:11 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v5 5/5] Documentation: RCU: Add TOC tree hooks
Date:   Wed, 26 Jun 2019 15:07:05 -0500
Message-Id: <20190626200705.24501-6-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626191249.21135-1-c0d1n61at3@gmail.com>
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add TOC tree hooks for:
  - rcu
  - listRCU
  - UP

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 Documentation/RCU/index.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/RCU/index.rst

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
new file mode 100644
index 000000000000..340a9725676c
--- /dev/null
+++ b/Documentation/RCU/index.rst
@@ -0,0 +1,19 @@
+.. _rcu_concepts:
+
+============
+RCU concepts
+============
+
+.. toctree::
+   :maxdepth: 1
+
+   rcu
+   listRCU
+   UP
+
+.. only:: subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.22.0

