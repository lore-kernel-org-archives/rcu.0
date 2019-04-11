Return-Path: <SRS0=j/BQ=SN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF82C10F13
	for <rcu@archiver.kernel.org>; Thu, 11 Apr 2019 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C305E2083E
	for <rcu@archiver.kernel.org>; Thu, 11 Apr 2019 08:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfDKIc0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:32:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfDKIc0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Apr 2019 04:32:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D8ADAE8B;
        Thu, 11 Apr 2019 08:32:25 +0000 (UTC)
Date:   Thu, 11 Apr 2019 10:32:23 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        rcu@vger.kernel.org, kernel-hardening@lists.openwall.com,
        kernel-team@android.com, keescook@chromium.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v3 1/3] module: Prepare for addition of new ro_after_init
 sections
In-Reply-To: <20190410195708.162185-1-joel@joelfernandes.org>
Message-ID: <alpine.LSU.2.21.1904111031580.27183@pobox.suse.cz>
References: <20190410195708.162185-1-joel@joelfernandes.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 10 Apr 2019, Joel Fernandes (Google) wrote:

> For the purposes of hardening modules by adding sections to
> ro_after_init sections, prepare for addition of new ro_after_init
> entries which we do in future patches. Create a table to which new
> entries could be added later. This makes it less error prone and reduce
> code duplication.
> 
> Cc: paulmck@linux.vnet.ibm.com
> Cc: rostedt@goodmis.org
> Cc: mathieu.desnoyers@efficios.com
> Cc: rcu@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> Cc: kernel-team@android.com
> Suggested-by: keescook@chromium.org
> Reviewed-by: keescook@chromium.org
> Acked-by: rostedt@goodmis.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
