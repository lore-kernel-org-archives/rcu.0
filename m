Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F0FC54EBD
	for <rcu@archiver.kernel.org>; Fri, 13 Jan 2023 13:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjAMN3F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjAMN2S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Jan 2023 08:28:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16D45D42E;
        Fri, 13 Jan 2023 05:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673616025; x=1705152025;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=962ix4Kbj8py4f4DI4pmUEFzHQKzIM5X1LKxKun+ZDE=;
  b=juLhBZp/Gw9t+/v49gHCVX1zq0P/PoEQCN+B5/SBQwNgd3lJmrDL5lAa
   F1DCwH17vpMHa7h/hI4Sism3OYyoFfF74GM+03MBL+TWTCr2ZzwreTWTy
   LVqKqwSIYVLRjKbmhuP2Z9KraL1c0o2tMdGabsttl9goBqSVNMKtnlZJf
   +wCGCJZei54XfVtEVgpr4kq2Q8SU8LbhInDCrWZqesvtp+NzX3I93CcvP
   9ocyJZKFxlso5BDQvgzrzKuP6/bIeHGEEEQLpNliZuFNraFa6T/sWn5xn
   XVfRAupBPHaoWWs09TCcDHXkIqBn60PFURaqVODaSajXvczVWg6SKeXyX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="322689337"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="322689337"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 05:20:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608168849"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608168849"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2023 05:20:14 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH rcu 13/27] drivers/hwtracing/stm: Remove "select SRCU"
In-Reply-To: <20230105003813.1770367-13-paulmck@kernel.org>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-13-paulmck@kernel.org>
Date:   Fri, 13 Jan 2023 15:19:50 +0200
Message-ID: <87fscetvux.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks,
--
Alex
