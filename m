Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8BBC433F5
	for <rcu@archiver.kernel.org>; Tue, 24 May 2022 00:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiEXAe7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 May 2022 20:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiEXAe6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 May 2022 20:34:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4489BAFA;
        Mon, 23 May 2022 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653352497; x=1684888497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xE7F46MotMjr8xH+TDvIW0Oiehk7XJmZ/wn6Ap1/F6E=;
  b=Rju06uFQ4TkPnurBjt+Cj7GOorF6lpV0sUge5PkbBsGGDFylZQWpCE8k
   4pOIl6HfzJF/LXqHqUfBhEk+9ihbCArQ99Y9VvlSDjeiHgLJksBjNNLo0
   VOeDFmGNquHZNWNKjjg7gV0XJNtBpdo2kJ+oG1IuupiBRgOpMcy1pOPga
   lPMAyL7Of+d9oxLOJfXqlEWqoH1ZdtQ3cZaQrVWe3aY8NmHljp9eZu3Ge
   isDUywPYaDe+LQkeqyaoXbW/oUaiitYWu11jI8Up0ZySfU5s4CGOJsOHQ
   PqPlTUDSN8aNNgV2xy0wzBYbgiXVqocz5BxqQbh4wOzlpV49EiO8XOmuv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273509531"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273509531"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 17:34:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="600952739"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 17:34:55 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add no-idle tasks check which in dyntick-idle state
Date:   Tue, 24 May 2022 08:34:52 +0800
Message-Id: <20220524003454.1887414-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

These commit stop scanning no-idle tasks which in dyntick-idle state and
remove idle-tasks check from warnings.

v1->v2:
fix build error when CONFIG_TASKS_RCU=n
v2->v3:
remove idle-tasks check from task_is_on_dyntick_idle()

Zqiang (2):
  rcu-tasks: Stop RCU Tasks scanning no-idle tasks which record on
    dyntick-idle entry
  rcu-tasks: Remove is_idle_task() from warnings in check_holdout_task()

 kernel/rcu/tasks.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.25.1

