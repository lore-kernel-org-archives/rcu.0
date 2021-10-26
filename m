Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EAFC433F5
	for <rcu@archiver.kernel.org>; Tue, 26 Oct 2021 04:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FE8604DC
	for <rcu@archiver.kernel.org>; Tue, 26 Oct 2021 04:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhJZEyB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Oct 2021 00:54:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37880 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhJZEyA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Oct 2021 00:54:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B46221956;
        Tue, 26 Oct 2021 04:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635223896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTrIR1qpCHAdIyJY41kHLwVd8GdNIlEwhZ7tf5LN0rk=;
        b=zFD32UvV6jXSDlZUHC6kHfGzkFF/2DxIhWYl737oxO8OOjtiNBA6ZRGdNhBh07aJzjYYT7
        yu5vdDYcsewPVHD69b5y71HNJyB93hckaw/IJILEDvu+do/bU9H2jmkQJp2/dLPaigj7Fk
        kotqdb6LvJAU6VI3VZl0AukEqbaXLMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635223896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTrIR1qpCHAdIyJY41kHLwVd8GdNIlEwhZ7tf5LN0rk=;
        b=T4S0e13qKPkIBr6K/64vYqg7ewSiEwk+fjTpC280Z0arftzqw5V1XrxOu9zaeoCLSCH+Lk
        a2/CPRDq48VG3XCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF76213B44;
        Tue, 26 Oct 2021 04:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P1BfG1aJd2GADQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Oct 2021 04:51:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add refcount analogy to What is RCU
In-reply-to: <YW9fMt04JqsaComr@casper.infradead.org>
References: <163468470814.17149.17892190693057737430@noble.neil.brown.name>,
 <YW9fMt04JqsaComr@casper.infradead.org>
Date:   Tue, 26 Oct 2021 15:51:31 +1100
Message-id: <163522389176.8576.4035743192114423983@noble.neil.brown.name>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 20 Oct 2021, Matthew Wilcox wrote:
> On Wed, Oct 20, 2021 at 10:05:08AM +1100, NeilBrown wrote:
> 
> some more minor glitches ...
> 
> > +7.  ANALOGY WITH REFERENCE COUNTING
> > +-----------------------------------
> > +
> > +Many uses of RCU do not look so much like reader-writer locking as
> > +illustrated by the previous section and so it can be helpful to have
> > +other analogies to draw on.  One such analogy involves thinking of its
> > +behaviour as similar to reference counting: RCU effectively provides a
> > +temporary protected reference on "everything".
> 
> This paragraph is a bit clunky.  How about:
> 
> The reader-writer analogy (illustrated by the previous section) is not
> always the easiest way to think about using RCU.  Another analogy which
> can be helpful is to consider RCU as providing an effective reference
> count on everything which is protected by RCU.

Yes, much better.  I chose "best" rather than "easiest" though.

Other changes Incorporated too.  Result to follow.

Thanks,
NeilBrown
