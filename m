Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D48C433FE
	for <rcu@archiver.kernel.org>; Wed, 23 Nov 2022 11:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiKWLqs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKWLqr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 06:46:47 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E311091F
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 03:46:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF4121F8C6;
        Wed, 23 Nov 2022 11:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669204005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=SqUX/4goCSHHkrQ7WbQyYqbF+UxH5EZLQzDUablKl2Q=;
        b=Y2bdG+PSVn/qC+O9dor2MS+7wmIOJgJ8kpaBxMgc/W+wwpfh22aa7Ua/GumM2YoPKnD9FP
        go6Kt4bR3etOlKXsHJETvj3gCCNLZA75J+orzqzIVp5mHheC2UZBawTC4LnhxSnKnTRtYQ
        11jkgGhJNbLnEVoCKRgcVTJaF8VypHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669204005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=SqUX/4goCSHHkrQ7WbQyYqbF+UxH5EZLQzDUablKl2Q=;
        b=B06RLmMnF/jncFbdGZlCdzKJFj8czMxIK8JF8L7E3ntn5pdBF/FKcX9t7sI0ByA4BeGOVo
        QAN3RSuABznN6hAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A159A13AE7;
        Wed, 23 Nov 2022 11:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tbOLJyUIfmNdVAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Nov 2022 11:46:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 35693A0709; Wed, 23 Nov 2022 12:46:45 +0100 (CET)
Date:   Wed, 23 Nov 2022 12:46:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     rcu@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: SRCU use from different contexts
Message-ID: <20221123114645.3aowv3hw4hxqr2ed@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

We were pondering with Amir about some issues with fsnotify subsystem and
as a building block we would need a mechanism to make sure write(2) has
completed. For simplicity we could imagine it like a sequence

write(2)
  START
  do stuff to perform write
  END

and we need a mechanism to wait for all processes that already passed START
to reach END. Ideally without blocking new writes while we wait for the
pending ones. Now this seems like a good task for SRCU. We could do:

write(2)
  srcu_read_lock(&sb->s_write_rcu);
  do stuff to perform write
  srcu_read_unlock(&sb->s_write_rcu);

and use synchronize_srcu(&sb->s_write_rcu) for waiting.

But the trouble with writes is there are things like aio or io_uring where
the part with srcu_read_lock() happens from one task (the submitter) while
the part with srcu_read_unlock() happens from another context (usually worker
thread triggered by IRQ reporting that the HW has finished the IO).

Is there any chance to make SRCU work in a situation like this? It seems to
me in principle it should be possible to make this work but maybe there are
some implementation constraints I'm missing... 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
