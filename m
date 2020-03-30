Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6BFC2D0EE
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A652078B
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 02:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jbVb7rCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgC3Cde (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:33:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39483 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgC3Cdd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id b62so17560365qkf.6
        for <rcu@vger.kernel.org>; Sun, 29 Mar 2020 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4Nrsn6k3gNjz4BOh5fYXmBusY3PxyBtFMiw/JeGaFI=;
        b=jbVb7rCDOQJz/kZvzoZg+nCBb4KUFEC+TOEHwI4K8l+pGSIYeCpBI96P01eV0zI9Xp
         UNulmO6Khkf8qD/AV6xh9l+zZWLcHZ1inkxlOpcjtRZ6MlaiZ2Q7kqdApuFN8GuiCNpu
         Wr49Ico00ahZmHYOYYNSeavwXVppbVFOAov0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4Nrsn6k3gNjz4BOh5fYXmBusY3PxyBtFMiw/JeGaFI=;
        b=H6Z23N9VQ76ofLa2UNGZCQ/Zl143OEpCn/r94gR/kguUtiB+TUcqs2fIBdsghn+YLp
         2e/DGhhz+FDBEJVLHKYA/da3Seo1Cm7XuXLt73GSMp1h1w2TAXdL/1HSqI6vkk7EmgAQ
         hgYHQq39DoiDAK4vpNfCIVjmz5/N+ovWr0a5+mHWC18ZBCfTy/jNJn9ShibrP9u6Icpf
         de+dsuz2IzoOnR9JopL/Nerl3n98iMfrbwp0JCO/SXm/8tzw0pKHQuV87sis+jISHgc1
         wP3LXHJ+HUJ/BkOFQZjS+CWdnB9UzXzgPb1FwTsqx2slQtZj6hy8/UGe5I/Hw/2nGc6F
         AKdA==
X-Gm-Message-State: ANhLgQ0XkqTXJlGCQjAXgz3+ktofF0k3B8w48GAQO/kmJC0eBkiDA3aj
        fftL1zrh3BUQ22kXQRjgQk/c6SUG6mE=
X-Google-Smtp-Source: ADFU+vtXh936KTMI8VcRei3o2sQCtsNDgg/nJ1FXpiRXs/K5bI0kVr1o3ZMKLWaw3v458vKR4rRcmA==
X-Received: by 2002:ae9:e00d:: with SMTP id m13mr9901951qkk.297.1585535610977;
        Sun, 29 Mar 2020 19:33:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:30 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 00/18] kfree_rcu() improvements for -rcu dev
Date:   Sun, 29 Mar 2020 22:32:30 -0400
Message-Id: <20200330023248.164994-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,
These patches improve kfree_rcu() to support:
- kfree_rcu() headless usage.
- both vmalloc() and slab free'ing support using array of pointers.
- simpler debugobjects handling.

It applies on rcu/dev branch as of March 29th.

Testing with rcuperf shows following changes. The memory footprint reduces and
batches go slightly up. This is assumed an acceptable change.

with all patches:
Total time taken by all kfree'ers: 27312964461 ns, loops: 20000, batches: 3120, memory footprint: 211MB
Total time taken by all kfree'ers: 26773272309 ns, loops: 20000, batches: 3084, memory footprint: 208M

without:
Total time taken by all kfree'ers: 25711621811 ns, loops: 20000, batches: 2814, memory footprint: 230MB          
 Total time taken by all kfree'ers: 25775800546 ns, loops: 20000, batches: 2755, memory footprint: 230MB

These have been pushed to the git tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/kfree)

cgit view:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/kfree

thanks,

 - Joel

Joel Fernandes (Google) (5):
rcu/tree: Simplify debug_objects handling
rcu/tree: Clarify emergency path comment better
rcu/tree: Remove extra next variable in kfree worker function
rcu/tree: Simplify is_vmalloc_addr expression
rcu/tree: Make kvfree_rcu() tolerate any alignment

Uladzislau Rezki (Sony) (13):
mm/list_lru.c: Rename kvfree_rcu() to local variant
rcu: Introduce kvfree_rcu() interface
rcu: Rename rcu_invoke_kfree_callback/rcu_kfree_callback
rcu: Rename __is_kfree_rcu_offset() macro
rcu: Rename kfree_call_rcu() to the kvfree_call_rcu().
mm/list_lru.c: Remove kvfree_rcu_local() function
rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
rcu/tree: Maintain separate array for vmalloc ptrs
rcu/tree: Introduce expedited_drain flag
rcu/tree: Support reclaim for head-less object
rcu/tiny: Move kvfree_call_rcu() out of header
rcu/tiny: Support reclaim for head-less object
rcu: Support headless variant in the kvfree_rcu()

include/linux/rcupdate.h   |  53 ++++++-
include/linux/rcutiny.h    |   6 +-
include/linux/rcutree.h    |   2 +-
include/trace/events/rcu.h |   8 +-
kernel/rcu/tiny.c          | 168 +++++++++++++++++++-
kernel/rcu/tree.c          | 315 ++++++++++++++++++++++++++-----------
mm/list_lru.c              |  11 +-
7 files changed, 443 insertions(+), 120 deletions(-)

--
2.26.0.rc2.310.g2932bb562d-goog

