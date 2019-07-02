Return-Path: <SRS0=UBUU=U7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED8DC4646D
	for <rcu@archiver.kernel.org>; Tue,  2 Jul 2019 03:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63CD21479
	for <rcu@archiver.kernel.org>; Tue,  2 Jul 2019 03:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGBDeP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:34:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726803AbfGBDeP (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 1 Jul 2019 23:34:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x623XEDi104932;
        Mon, 1 Jul 2019 23:34:13 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfumaqqxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 23:34:12 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x623U5tx026605;
        Tue, 2 Jul 2019 03:34:11 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2tdym6u9u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 03:34:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x623YBsE31064526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jul 2019 03:34:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03FD0B205F;
        Tue,  2 Jul 2019 03:34:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4CE2B2068;
        Tue,  2 Jul 2019 03:34:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.179.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jul 2019 03:34:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 90F8416C3620; Mon,  1 Jul 2019 20:34:10 -0700 (PDT)
Date:   Mon, 1 Jul 2019 20:34:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: [RFC 3/3] Revert "rcutorture: Tweak kvm options"
Message-ID: <20190702033410.GH26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-3-joel@joelfernandes.org>
 <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
 <20190701141403.GA246562@google.com>
 <CACT4Y+bJ-tNvMsfHcFEsWdjtBnaLTP9q=u7PCk4VMVPvW51WLQ@mail.gmail.com>
 <20190701145920.GA71270@google.com>
 <20190701202727.GR26519@linux.ibm.com>
 <20190701213107.GA240327@google.com>
 <20190701215020.GW26519@linux.ibm.com>
 <20190702025645.GC240327@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702025645.GC240327@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020036
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 01, 2019 at 10:56:45PM -0400, Joel Fernandes wrote:
> On Mon, Jul 01, 2019 at 02:50:20PM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 01, 2019 at 05:31:07PM -0400, Joel Fernandes wrote:
> > > On Mon, Jul 01, 2019 at 01:27:27PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Jul 01, 2019 at 10:59:20AM -0400, Joel Fernandes wrote:
> > > > > On Mon, Jul 01, 2019 at 04:48:43PM +0200, Dmitry Vyukov wrote:
> > > > > > On Mon, Jul 1, 2019 at 4:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > >
> > > > > > > On Mon, Jul 01, 2019 at 02:23:58PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > > > > On 2019-07-01 00:04:15 [-0400], Joel Fernandes (Google) wrote:
> > > > > > > > > This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438 which
> > > > > > > > > causes kvm.sh to not run on my machines. The qemu-system-x86_64 command
> > > > > > > > > runs but does nothing.
> > > > > > > >
> > > > > > > > Nope. I would like to know *why* you need 'noapic' to work. Is it a
> > > > > > > > brand new or old qemu-system-x86_64?
> > > > > > >
> > > > > > > I did not have time to debug yesterday and I posted this particular revert as
> > > > > > > an 'RFC' just to make aware of this problem.
> > > > > > >
> > > > > > > I spent some more time just now, it looks like this has nothing to do with
> > > > > > > 'noapic' and appears to be a problem on debian distros with the e1000e NIC.
> > > > > > > May be this NIC was added to the virtual hardware because of -machine in the
> > > > > > > patch?
> > > > > > >
> > > > > > > Any if I add the following to the qemu command that kvm.sh runs, it works again:
> > > > > > > -net nic,model=e1000
> > > > > > >
> > > > > > > Without it I get:
> > > > > > >  qemu-system-x86_64: Initialization of device e1000e failed: failed to find romfile "efi-e1000e.rom"
> > > > > > >
> > > > > > > Seems to be mentioned here:
> > > > > > > https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1737211
> > > > > > >
> > > > > > > And in syzkaller as well:
> > > > > > > https://github.com/google/syzkaller/blob/master/vm/qemu/qemu.go#L88
> > > > > > >
> > > > > > > Adding Dmitry who is syzkaller owner for any thoughts as well.
> > > > > > 
> > > > > > I don't have many thoughts on this. That particular error looked like
> > > > > > a bug in the package in the particular distro/version.
> > > > > 
> > > > > Paul, what is your preference here? Can we add the -net nic,model=e1000 to
> > > > > fix it for the benefit of any other Debian folks running kvm.sh?
> > > > > 
> > > > > Or do you prefer if I just built my own custom Qemu? I can't upgrade Qemu on
> > > > > this machine unfortunately. But may be I can build my own.
> > > > > 
> > > > > I prefer the -net option since I can save the time for something else. ;) Let
> > > > > me know what you prefer and I'll fix it accordingly.
> > > > 
> > > > Why not just add the following to your kvm.sh command line?
> > > > 
> > > > 	--qemu-args "-net nic,model=e1000"
> > > > 
> > > > Easy workaround and no need to wait for changes to hit mainline.
> > > > 
> > > > Yes, I am perhaps naively assuming that the qemu bug in Debian will
> > > > be fixed in about the time that it would take for any change to the
> > > > rcutorture scripting to make its way into mainline.  ;-)
> > > 
> > > Thanks for the pointer to the args! Just what I wanted.
> > > 
> > > Only down side is then we run into the risk of other developers running
> > > kvm.sh on debian as well and wondering why torture is broken. Perhaps the kvm
> > > tweaks commit hasn't hit that many machines yet but it might. At least we
> > > have this discussion archive here to guide such poor souls, if we don't want
> > > to append these arguments by default ;-)
> > 
> > What is the likely timeframe of a qemu fix in Debian?
> 
> I dug through debian's archive. Indeed they have already fixed it
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=884240

Whew!!!  ;-)

> I may need to upgrade my debian release or pull patches from debian testing,
> or something. It might not be worth the trouble and I could just as well have a
> custom kvm.sh command in my bashrc.

It is good to have the flexibility!

> > This does raise a question of rcutorture workarounds in general.
> > There will be times when some failure or another is expected behavior.
> > For example, in current -rcu getting an rcutorture_oom_notify() splat or
> > the occasional RCU CPU stall warning from TREE04 is expected behavior.
> > This is because rcutorture's forward-progress testing is more aggressive
> > that the TREE04 configuration can currently handle (but I am working
> > on it).
> 
> I see, thanks good to know. I would love try out those tests as well.

Just do "--config TREE04" on -rcu's "dev" branch.  ;-)

> > For internal-to-RCU issues, I could make rcutorture warn of the likely
> > problem.  for external-to-RCU issues, such as your fun with Debian qemu,
> > that won't work all that well.  I could blog about the external-to-RCU
> > issues, if that would help.  Or we could trust people to either do
> > the websearch or ask for help on the rcu email list.
> 
> Yes this discussion is here. I also feel it may not be worth working around
> since it is a distro bug which is already fixed it. Another approach could be
> to look for that error message in qemu-output and tell people to use a custom
> command or upgrade when they run the script. But that also may not be worth
> it unless more people are running into this due to the default distro package
> they are using.

True enough, got lucky this time.

> > Thoughts?
> > 
> > > The other fix, could be I just build and run a new custom qemu instance but I
> > > am happy with qemu-args as well.
> > 
> > My concern is that applying the workaround to the rcutorture scripts might
> > break someone else.  Plus it is hard to synchronize with qemu releases,
> > to say nothing of distro releases containing qemu.  Hence my preference
> > for use of kvm.sh's --qemu-args for this purpose.
> 
> Yes, that works for me.
> 
> Thanks a lot for the discussion!

Happy rcutorturing!  ;-)

							Thanx, Paul
